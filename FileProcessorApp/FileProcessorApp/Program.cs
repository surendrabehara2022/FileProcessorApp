class Program
{
    public static async Task Main(string[] args)
    {
        Console.WriteLine("Starting dummy background processing...");
        var processingStartTime = DateTime.Now;

        for (var i = 0; i < 88; i++)
        {
            await ProcessFileAsync(i);
        }

        Console.WriteLine("Dummy background processing completed.");
        Console.WriteLine("Total time to complete the processing in seconds: " + (DateTime.Now - processingStartTime).TotalSeconds);
    }

    public static async Task ProcessFileAsync(int number)
    {
        // Simulate file processing
        Console.WriteLine($"Processing start for: {number}");
        await Task.Delay(20000); // Simulate some delay
        Console.WriteLine($"Completed processing for: {number}");
    }
}