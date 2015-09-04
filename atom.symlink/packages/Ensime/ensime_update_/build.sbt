import sbt._

import IO._

import java.io._

scalaVersion := "2.11.7"

// allows local builds of scala
resolvers += Resolver.mavenLocal

ivyScala := ivyScala.value map { _.copy(overrideScalaVersion = true) }

resolvers += Resolver.sonatypeRepo("snapshots")

resolvers += "Typesafe repository" at "http://repo.typesafe.com/typesafe/releases/"

resolvers += "Akka Repo" at "http://repo.akka.io/repository"

libraryDependencies ++= Seq(
  "org.ensime" %% "ensime" % "0.9.10-SNAPSHOT",
  "org.scala-lang" % "scala-compiler" % scalaVersion.value force(),
  "org.scala-lang" % "scala-reflect" % scalaVersion.value force(),
  "org.scala-lang" % "scalap" % scalaVersion.value force()
)

val saveClasspathTask = TaskKey[Unit]("saveClasspath", "Save the classpath to a file")

saveClasspathTask := {
  val managed = (managedClasspath in Runtime).value.map(_.data.getAbsolutePath)
  val unmanaged = (unmanagedClasspath in Runtime).value.map(_.data.getAbsolutePath)
  val out = file("""/Users/ernest/.dotfiles/atom.symlink/packages/Ensime/classpath_2.11.7_0.9.10-SNAPSHOT""")
  write(out, (unmanaged ++ managed).mkString(File.pathSeparator))
}