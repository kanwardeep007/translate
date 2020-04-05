STEP 1
  To run this project we need docker to be installed on the machine

  If running on a mac follow the instructions here - https://docs.docker.com/docker-for-mac/install/

  If running Windows follow the instructions here - https://docs.docker.com/docker-for-windows/

  If running variation of Linux follow the instructions here - https://docs.docker.com/install/linux/docker-ce/ubuntu/

STEP 2
  Once docker is installed on mac we need to start docker desktop before doing the following steps

STEP 3
 Run this command in terminal. It will build the image for the project
 docker build -t translate_v1  <path_to_directory_of_project>

STEP 4
 Run this command to start the container using the image built in the previous step.(Running this command will also run tests before starting the container)

 docker run -p 3000:3000 translate_v1:latest 


STEP 5
  Open any web browser (chrome, firefox, safari) and enter the below URL (Contraint - Shakespeare api only allows 5 translations per hour from the same ip address)

  http://localhost:3000/pokemons/charizard
