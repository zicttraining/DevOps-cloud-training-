
                            git config user.email "nhu.luong@zicloudtech.com"
                            git config user.name "nhu.luong"
                            BUILD_NUMBER=${BUILD_NUMBER}
                            echo $BUILD_NUMBER
                            sed -i "s/tetrisv1:${imageTag}/tetrisv1:${BUILD_NUMBER}/" deployment-service.yml
                            git add deployment-service.yml
                            git add --all
                            git add .
                            git commit -m "Update deployment Image to version ${BUILD_NUMBER}"**
                            git clean -n
                            git push -f https://${GITHUB_TOKEN}@github.com/nhuluong2024/DevSecOps-Demo.git HEAD:main
                        