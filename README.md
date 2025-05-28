# proyecto-redes-II
Proyecto del curso de redes II

# Infraestructura Empresarios S.A. en AWS con Terraform

Proyecto de simulación de infraestructura de red multinacional para Empresarios S.A., utilizando AWS y aprovisionamiento con Terraform.

## Estructura del proyecto
- 5 sedes (VPCs): 3 nacionales y 2 internacionales (España y EE.UU.)
- Sede Central con subredes por departamento y una subred pública para clientes
- Sucursales con subred simplificada
- Comunicación entre sedes por Transit Gateway (a implementar)
- Instancias EC2 para simular dispositivos

## Despliegue
1. Clona el repositorio
2. Configura tus credenciales de AWS (`aws configure`)
3. Ejecuta:
    ```bash
    terraform init
    terraform plan
    terraform apply
    ```
4. Revisa los outputs para obtener las IPs de las instancias

## Autores
- Kevin Borge (kborget@umg.edu.gt.com)

