package pageview

import org.apache.hadoop.fs.Path
import org.apache.hadoop.io.{IntWritable, Text}
import org.apache.hadoop.mapreduce.Job
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat

object PageViewMain extends App {

  if(args.length != 2){
    println("Usage: WordDriver <input dir> <output dir>")
    System.exit(-1)
  }
  //Instantiates job
  val job = Job.getInstance()

  //Sets jar file that contains driver, mapper and reducer
  job.setJarByClass(PageViewMain.getClass)

  //Specifies job name
  job.setJobName("Page Count")

  //Specifies input path
  FileInputFormat.setInputPaths(job, new Path(args(0)))
  //Specifies output path
  FileOutputFormat.setOutputPath(job, new Path(args(1)))

  //Specify mapper and reducer
  job.setMapperClass(classOf[PageMapper])
  job.setReducerClass(classOf[PageReducer])

  //Specifies job's output key, value classes
  job.setOutputKeyClass(classOf[Text])
  job.setOutputValueClass(classOf[IntWritable])

  val success = job.waitForCompletion(true)
  System.exit(if (success) 0 else 1)

}

