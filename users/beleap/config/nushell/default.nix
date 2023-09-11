{
  git = builtins.readFile (./. + "/git.nu");

  kubectl = ''
    def "nu-complete kubectl namespaces" [] {
      ^kubectl get namespaces -o json | from json | get items | get metadata | select name | get name
    }

    def "nu-complete kubectl api-resources" [] {
      ^kubectl api-resources -o name | lines
    }

    export extern "kubectl get" [
      resource?: string@"nu-complete kubectl api-resources"
    ]

    export extern "kubectl" [
      --namespace(-n): string@"nu-complete kubectl namespaces"
    ]
  '';
}
