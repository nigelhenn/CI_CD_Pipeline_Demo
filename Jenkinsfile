stage('Generate Ansible Inventory') {
  steps {
    withCredentials([
      file(credentialsId: 'terraform-key', variable: 'TF_KEY')
    ]) {
      sh 'terraform output -json > tf_output.json'
      script {
        def tfOutput = readJSON file: 'tf_output.json'
        def ips = tfOutput.web_instance_ips?.value ?: []
        def inventory = [
          all: [
            hosts: ips.collectEntries { ip ->
              [ (ip): [
                ansible_user: "ec2-user",
                ansible_ssh_private_key_file: env.TF_KEY
              ]]
            }
          ]
        ]
        writeFile file: 'inventory.yaml', text: groovy.json.JsonOutput.prettyPrint(groovy.json.JsonOutput.toJson(inventory))
      }
    }
  }
}
