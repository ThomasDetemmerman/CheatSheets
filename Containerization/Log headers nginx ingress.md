https://msazure.club/nginx-ingress-controller-debugging-print-http-raw-header/

kubectl exec YOUR_NGINX_INGRESS_CONTROLLER_POD -it -- cat /etc/nginx/template/nginx.tmpl > nginx.tmpl

Open nginx.tmpl, add below code block after location {{ $path }} {
```
            header_filter_by_lua_block {
				local h = ngx.req.get_headers()
				local request_headers_all = ""
				for k, v in pairs(h) do
					request_headers_all = request_headers_all .. ""..k..": "..v..";"
				end
				ngx.log(ngx.ERR, request_headers_all)
            }
```
kubectl create configmap nginx-template --from-file=nginx.tmpl=nginx.tmpl -n=nginx
```
        volumeMounts:
          - mountPath: /etc/nginx/template
            name: nginx-template-volume
            readOnly: true
      volumes:
        - name: nginx-template-volume
          configMap:
            name: nginx-template
            items:
            - key: nginx.tmpl
              path: nginx.tmpl
```
kubectl delete configmap nginx-template -n=nginx
configmap "nginx-template" deleted

kubectl create configmap nginx-template --from-file=nginx.tmpl=nginx.tmpl -n=nginx
configmap/nginx-template created

kubectl delete pod YOUR_NGINX_INGRESS_CONTROLLER_POD

Sample debug output from nginx ingress controller

2019/08/13 07:22:58 [error] 189#189: *64 [lua] header_filter_by_lua:7: host: wow.msazure.club;azds-route-as: default;request-id: |a5fc14d6cde2d347821834d7e1ff81d4.27fa889e_1.1.;request-context: appId=cid-v1:652de4b3-436a-483a-aad2-28e994dd307f; 
