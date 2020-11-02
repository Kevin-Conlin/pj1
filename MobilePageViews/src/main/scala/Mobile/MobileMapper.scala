package Mobile

import org.apache.hadoop.io.{IntWritable, LongWritable, Text}
import org.apache.hadoop.mapreduce.Mapper

class MobileMapper extends Mapper[LongWritable, Text, Text, IntWritable] {

  override def map(key: LongWritable, value: Text, context: Mapper[LongWritable, Text, Text, IntWritable]#Context): Unit = {

    val line = value.toString

    val list = line.split("\\s").filter(_.length > 0).map(_.toString).toList

    if (list(0) == "en.m") {
      context.write(new Text(list(1)), new IntWritable(list(2).toInt))
    }
  }
}