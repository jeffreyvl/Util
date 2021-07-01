Movie movie = JsonConvert.DeserializeObject<Movie>(File.ReadAllText(@"c:\movie.json"));

using (StreamReader fileReader = File.OpenText(@"c:\movie.json"))
{
    JsonSerializer serializer = new JsonSerializer();
    Movie movie = (Movie)serializer.Deserialize(fileReader, typeof(Movie));
}

using (StreamReader fileReader = new StreamReader(@"file.json"))
{
	var json = fileReader.ReadToEnd();
	Movie movie = JsonConvert.DeserializeObject<Movie>(json);
}