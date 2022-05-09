import com.couchbase.client.scala.json.JsonObject
import com.couchbase.spark.kv.Upsert
import org.apache.spark.sql.SparkSession
import com.couchbase.spark.{Keyspace, _}

object CouchbaseUpsert {
  def main(args: Array[String]): Unit = {
    val spark = SparkSession
      .builder()
      .appName("Couchbase upsert")
      .config("spark.couchbase.connectionString", "couchbase")
      .config("spark.couchbase.username", "Administrator")
      .config("spark.couchbase.password", "coffee")
      .getOrCreate()

    val doc1 = JsonObject(
      "id" -> "1",
      "title" -> "test 1"
    )

    val doc2 = JsonObject(
      "id" -> "2",
      "title" -> "test 2"
    )

    spark
      .sparkContext
      .parallelize(Seq(doc1, doc2))
      .map { x =>
        Upsert(x.str("id"), x)
      }
      .couchbaseUpsert(Keyspace(bucket = Some("item")))
      .collect()
      .foreach(println)
  }
}
