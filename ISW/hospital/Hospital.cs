public class Hospital {
    private virtual ICollection<HospitalBased> HospitalBasedAmbulances {get; set;}
    private virtual ICollection<Deployment> Supports {get; set;}
    private virtual ICollection<EmergecyCall> EmergencyCalls {get; set;}

    public string Name;
    public string Address;
    public double Latitude, Longitude;
    public EmergencyCallService Service;

    public Hospital() {
        HospitalBasedAmbulances = new List<HospitalBased>();
        Supports = new List<Deployment>();
        EmergencyCalls = new List<EmergencyCall>();
    }

    public Hospital(string Name, string Address, double Latitude, double Longitude, EmergencyCallService Service) {
        this.Name = Name;
        this.Address = Address;
        this.Longitude = Longitude;
        this.Latitude = Latitude;
        this.EmergencyCallService = Service;
        HospitalBasedAmbulances = new List<HospitalBased>();
        Supports = new List<Deployment>();
        EmergencyCalls = new List<EmergencyCall>();
    }
}

