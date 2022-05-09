import sbt.Keys.organization


lazy val root = (project in file("."))
  .settings(
    name := "couchbase-upsert",

    organization := "test-org",

    version := "0.0.1",

    scalaVersion := "2.12.15",

    libraryDependencies ++= Seq(
      "org.apache.spark" %% "spark-core" % "3.2.1",
      "org.apache.spark" %% "spark-sql" % "3.2.1",
      "com.couchbase.client" %% "spark-connector" % "3.2.0"
    ),

    assembly / assemblyMergeStrategy := {
      case PathList("META-INF", _*) => MergeStrategy.discard
      case _ => MergeStrategy.first
    }
  )
