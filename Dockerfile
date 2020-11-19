FROM 	alpine:latest AS builder
RUN 	apk add --no-cache 	python3 					\
							py3-yaml					\
							python3-dev					\
							bash						\
							gcc							\
							musl-dev					\
							npm							\
							openssl						\
							nginx	 					\
							openldap 					\
							openldap-dev 				\
							openldap-clients 			\
							openldap-back-mdb 			\
							openldap-overlay-memberof 	\
							openldap-overlay-ppolicy 	\
							openldap-overlay-refint 	\
							openldap-overlay-auditlog 	\
							openldap-back-monitor 		
COPY 	modules /container
RUN 	/container/build_builder.sh

FROM 	alpine:latest
RUN 	apk add --no-cache 	python3 			\
				py3-yaml						\
				runit							\
				bash							\
				shadow							\
				openssl							\
				nginx	 						\
				openssh-keygen					\
				openldap 						\
				openldap-clients 				\
				openldap-back-mdb 				\
				openldap-overlay-memberof 		\
				openldap-overlay-ppolicy 		\
				openldap-overlay-refint 		\
				openldap-overlay-auditlog 		\
				openldap-back-monitor 		
COPY 	container /container
COPY	--from=builder /container/out.tar.gz /container/out.tar.gz
RUN 	/container/build.sh
ENTRYPOINT ["/container/tools/run"]
EXPOSE 80 443 389 636
