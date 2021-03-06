package LinkCount

import org.apache.hadoop.io.{IntWritable, LongWritable, Text}
import org.apache.hadoop.mapreduce.Mapper

class LinkMapper extends Mapper[LongWritable, Text, Text, IntWritable] {

  override def map(key: LongWritable, value: Text, context: Mapper[LongWritable, Text, Text, IntWritable]#Context): Unit = {

    val line = value.toString

    val list = line.split("\\s").filter(_.length > 0).map(_.toString).toList

    if (list.length > 3) {
      if (list(list.length - 2) == "link") {
        context.write(new Text(list(0)), new IntWritable(list(list.length - 1).toInt))
      }
    }
  }

}



