package LinkCount

import org.apache.hadoop.io.{IntWritable, LongWritable, Text}
import org.apache.hadoop.mapreduce.Mapper

class LinkMapper extends Mapper[LongWritable, Text, Text, IntWritable] {

  override def map(key: LongWritable, value: Text, context: Mapper[LongWritable, Text, Text, IntWritable]#Context): Unit = {

    val line = value.toString

    val list = line.split("\\W+").filter(_.length > 0).map(_.toString).toList

    if (list.length > 3) {
      if (list(2) == "link") {
        context.write(new Text(list(0)), new IntWritable(1))
      }
    }
  }

}



