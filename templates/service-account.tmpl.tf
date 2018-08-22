terraform {
 backend "gcs" {
   bucket  = "${TF_ADMIN}"
   path    = "/terraform.tfstate"
   project = "${TF_ADMIN}"
 }
 data "google_iam_policy" "{{ .Env.SERVICE_ACCOUNT_LONG }}" {
   binding {
     role = "roles/cloudsql.client"

     members = [
       "serviceAccount:{{ .Env.SERVICE_ACCOUNT_LONG }}",
     ]
   }
   binding {
     role = "roles/storage.admin"

     members = [
       "serviceAccount:{{ .Env.SERVICE_ACCOUNT_LONG }}",
     ]
   }
 }
}
