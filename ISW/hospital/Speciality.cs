public class Speciality {
    private virtual ICollection<Symptom> Symptoms {get; set;}
    private virtual ICollection<Deployment> Supports {get; set;}

    public string Name;

    public Speciality () {
        Symptoms = new List<Symptom>();
        Supports = new List<Deployment>();
    }

    public Speciality (string Name) {
        this.Name = Name;
        Symptoms = new List<Symptom>();
        Supports = new List<Deployment>();
    }
}
