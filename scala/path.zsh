#JAVA HOME
if [ -d "/usr/lib/jvm/jre-1.7.0-openjdk.x86_64/bin/java" ]; then
    export JAVA_HOME="/usr/lib/jvm/jre-1.7.0-openjdk.x86_64/bin/java"
    $JAVA_HOME/bin/java -version
else
    if [ -d "/usr/lib/jvm/java-6-openjdk-amd64/jre" ]; then
        export JAVA_HOME="/usr/lib/jvm/java-6-openjdk-amd64/jre"
        $JAVA_HOME/bin/java -version
    else
        if [ -d "/usr/lib/jvm/java-7-openjdk-amd64/jre" ]; then
            export JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64/jre"
            $JAVA_HOME/bin/java -version
        else
            if [ -d "/usr/libexec/java_home" ]; then
                export JAVA_HOME=$(/usr/libexec/java_home)
                $JAVA_HOME/bin/java -version
            else
                echo "Couldn't find JAVA_HOME"
            fi
        fi
    fi
fi

export CONSCRIPT_OPTS="-XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -Xmx3G -XX:MaxPermSize=1G -Duser.timezone=UTC"
