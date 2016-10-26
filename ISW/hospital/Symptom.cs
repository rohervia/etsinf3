public class Symptom {
    private virtual ICollection<Speciality> specialities {get; set;}
    private virtual ICollection<EmergencyCall> emergencyCalls {get; set;}

    public int StageOfGravity;
    public int Duration;
    public string Description;

    public Symptom () {
        specialities = new List<Speciality>();
        emergencyCalls = new List<EmergencyCall>();
    }

    public Symptom(int StageOfGravity, int Duration, string Description) {
        this.StageOfGravity = StageOfGravity;
        this.Duration = Duration;
        this.Description = Description;
        specialities = new List<Speciality>();
        emergencyCalls = new List<EmergencyCall>();
    }
}
