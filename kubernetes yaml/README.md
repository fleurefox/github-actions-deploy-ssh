# Kubernetes Yaml File
Dalam skenario file ini docker image sudah dibuild dan dipush sehingga menyisakan file yaml untuk container orchestrationnya saja.

## Terdiri dari deployment dan service
### 1. Apiversion dan kind 
Menunjukkan versi dan jenis file
### 2. Metadata
Berisi informasi metadata untuk objek service, seperti nama.
### 3. spec
Adalah spesifikasi untuk deployment, termasuk jumlah replika, selector, dan template.
`port: 3000' merupakan port engine yang digunakan nodejs
### 4. Type (hanya ada pada service)
Menunjukkan bahwa service akan di-expose melalui IP internal cluster.

#Command
Pastikan dependencies dan kubectl sudah terinstall terlebih dahulu
`kubectl apply -f nodejs-deployment.yaml`
`kubectl apply -f nodejs-service.yaml`

cek status dengan
`kubectl get deployments`
`kubectl get services`




