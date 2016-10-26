public class EmergencyCall 
{
    private ICollection<Symptom> symptoms {get; set;}

    public double latitude {get; set;}
    public double longitude {get; set;}
    public DateTime date {get; set;}
    public Patient patient {get; set;}
    public Ambulance ambulance {get; set;}
    public Hospital hospital {get; set;}

    public EmergencyCall()
    {
        symptoms = new List<Symptom>();
    }

    public EmergencyCall(double latitude, double longitude, DateTime date,
            Patient patient, Ambulance ambulance, Hospital hospital,
            ICollection<Symptom> symptoms)
    {
    }

    public ICollection<Symptom> listSymptoms(){}
    public EmergencyCall getSymptom( /* ... */ ){}
    public void addSympton(Symptom symptom){}

}
