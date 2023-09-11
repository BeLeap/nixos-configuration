# Utility functions
def resource-items [resource: string, fullcmd: string] {
    let ns = namespace $fullcmd

    if ($ns | str length) == 0 {
        ^kubectl get $resource -o name | lines | split column "/" | get column2 | str trim
    } else {
        ^kubectl -n $ns get $resource -o name | lines | split column "/" | get column2 | str trim
    }
}

def finalword [words: string] {
    words | split row " " | last
}

def namespace [line:string] {
    $line | parse -r "(?P<n>-n [a-zA-Z-0-9]+)|(?P<namespace>--namespace [a-zA-Z-0-9]+)"
    | each { |it| $"($it.n)($it.namespace)" }
    | str find-replace "-n " "" | str find-replace "--namespace" ""
}

# Namespace
def "nu-complete kubectl namespace" [line: string, pos: int] {
    resource-items namespace ""
}

# Logs
def "nu-complete kubectl logs" [] {
    ^kubectl get po,deployment,job -o name | lines | str trim
}
export extern "kubectl logs" [
    target?: string@"nu-complete kubectl logs" # Target
    --container(-c): string # Print the logs of this container
    --follow(-f): bool #  Specify if the logs should be streamed.
    --ignore-errors: bool # If watching / following pod logs, allow for any errors that occur to be non-fatal
    --insecure-skip-tls-verify-backend: bool # Skip verifying the identity of the kubelet that logs are requested from.
    # In theory, an attacker could provide invalid log content back. You might want to use this if your kubelet serving
    # certificates have expired.

    --limit-bytes: int # Maximum bytes of logs to return. Defaults to no limit.
    --max-log-requests: int # Maximum bytes of logs to return. Defaults to no limit.
    --pod-running-timeout: string # The length of time (like 5s, 2m, or 3h, higher than zero) to wait until at least one
    # pod is running

    --prefix: bool # Prefix each log line with the log source (pod name and container name)
    --previous(-p): bool #  If true, print the logs for the previous instance of the container in a pod if it exists.
    --selector(-l): string # Selector (label query) to filter on.
    --since: string # Only return logs newer than a relative duration like 5s, 2m, or 3h. Defaults to all logs. Only one of
    # since-time / since may be used.

    --since-time: string # Only return logs after a specific date (RFC3339). Defaults to all logs. Only one of since-time /
    # since may be used.

    --tail: int #  Lines of recent log file to display. Defaults to -1 with no selector, showing all log lines otherwise
    # 10, if a selector is provided.

    --timestamps: bool # Include timestamps on each line in the log output
]

# Resources
def "nu-complete kubectl resources" [line: string, pos: int] {
    ^kubectl api-resources | lines | skip 1 | parse -r "^([a-z]+) " | get Capture1
}

# Kubectl
def "nu-complete kubectl" [] {
    ^kubectl | lines | find "  " | str trim | parse "{command} {help}" | str trim | where command != "kubectl" | get command
}

def "nu-complete kubectl resource names" [line: string, pos: int] {

    resource-items ( $line | split row " " | last ) $line

    # if (queryns | str length) > 0 {
    #     resource-items $resource $queryns
    # } else {
    #     resource-items $resource ""
    # }
}

# Kubectl
export extern "kubectl" [
  command?: string@"nu-complete kubectl"
  resource?: string@"nu-complete kubectl resources"
  name?: string@"nu-complete kubectl resource names"
  --namespace(-n): string@"nu-complete kubectl namespace"
  -A
]
