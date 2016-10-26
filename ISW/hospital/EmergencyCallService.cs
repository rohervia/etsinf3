public class EmergencyCallService
{
    private virtual ICollection<Hospital> Hospitals {get;}
    private virtual ICollection<Ambulances> Ambulances {get;}
    private virtual ICollection<EmergencyCall> EmergencyCalls {get;}

    public EmergencyCallService()
    {
        Hospitals = new List<Hospital>();
        Ambulances = new List<Ambulances>();
        EmergencyCalls = new List<EmergencyCall>();
    }
}
