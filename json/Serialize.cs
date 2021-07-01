string json = JsonConvert.SerializeObject(movie, Formatting.Indented);

File.WriteAllText(@"c:\movie.json", JsonConvert.SerializeObject(movie));

using (StreamWriter file = File.CreateText(@"c:\movie.json"))
{
    JsonSerializer serializer = new JsonSerializer();
    serializer.Serialize(file, movie);
}