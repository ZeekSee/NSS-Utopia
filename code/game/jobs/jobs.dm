
GLOBAL_LIST_EMPTY(assistant_occupations)


GLOBAL_LIST_INIT(command_positions, list(
	"Captain",
	"Head of Personnel",
	"Peacemakers Leader",
	"Chief Engineer",
	"Research Director",
	"Chief Medical Officer"
))


GLOBAL_LIST_INIT(engineering_positions, list(
	"Chief Engineer",
	"Station Engineer",
	"Mechanic"
))


GLOBAL_LIST_INIT(medical_positions, list(
	"Chief Medical Officer",
	"Medical Doctor",
	"Geneticist",
	"Psychiatrist",
	"Chemist",
	"Virologist",
	"Paramedic",
	"Coroner",
	"Intern"
))

GLOBAL_LIST_INIT(additional_medical_positions, list(
	"Brig Physician" // So they will not be part of medical in crew manifest
))

GLOBAL_LIST_INIT(science_positions, list(
	"Research Director",
	"Scientist",
	"Geneticist"	//Part of both medical and science
))

GLOBAL_LIST_INIT(security_positions, list(
	"Peacemakers Leader",
	"Warden",
	"Detective",
	"Peacemaker",
	"Peacemaker Pod Pilot",
	"Peacemaker Cadet"
))

GLOBAL_LIST_INIT(technically_security_positions,(
	security_positions - list("Brig Physician") // Add here jobs, that are security, but **do not shitcurs** (or you dont want them give them exp)
))

//BS12 EDIT
GLOBAL_LIST_INIT(support_positions, list(
	"Head of Personnel",
	"Bartender",
	"Botanist",
	"Chef",
	"Janitor",
	"Librarian",
	"Quartermaster",
	"Cargo Technician",
	"Shaft Miner",
	"Internal Affairs Agent",
	"Chaplain",
	"Clown",
	"Mime",
	"Barber"
))

GLOBAL_LIST_INIT(supply_positions, list(
	"Head of Personnel",
	"Quartermaster",
	"Cargo Technician",
	"Shaft Miner"
))

GLOBAL_LIST_INIT(service_positions, (list("Head of Personnel") + (support_positions - supply_positions)))

GLOBAL_LIST_INIT(civilian_positions, list(
	"Civilian",
	"Prisoner"
))

GLOBAL_LIST_INIT(nonhuman_positions, list(
	"AI",
	"Cyborg",
	"Drone",
	"pAI"
))

GLOBAL_LIST_INIT(whitelisted_positions, list(
	"Barber",
	"Mechanic",
	"Peacemaker Pod Pilot"
))


/proc/guest_jobbans(var/job)
	return (job in GLOB.whitelisted_positions)

/proc/get_job_datums()
	var/list/occupations = list()
	var/list/all_jobs = typesof(/datum/job)

	for(var/A in all_jobs)
		var/datum/job/job = new A()
		if(!job)	continue
		occupations += job

	return occupations

/proc/get_alternate_titles(var/job)
	var/list/jobs = get_job_datums()
	var/list/titles = list()

	for(var/datum/job/J in jobs)
		if(!J)	continue
		if(J.title == job)
			titles = J.alt_titles

	return titles

GLOBAL_LIST_INIT(exp_jobsmap, list(
	EXP_TYPE_LIVING = list(), // all living mobs
	EXP_TYPE_CREW = list(titles = command_positions | engineering_positions | medical_positions | science_positions | support_positions | supply_positions | security_positions | civilian_positions | list("AI","Cyborg") | whitelisted_positions), // crew positions
	EXP_TYPE_SPECIAL = list(), // antags, ERT, etc
	EXP_TYPE_GHOST = list(), // dead people, observers
	EXP_TYPE_EXEMPT = list(), // special grandfather setting
	EXP_TYPE_COMMAND = list(titles = command_positions),
	EXP_TYPE_ENGINEERING = list(titles = engineering_positions),
	EXP_TYPE_MEDICAL = list(titles = medical_positions | additional_medical_positions),
	EXP_TYPE_SCIENCE = list(titles = science_positions),
	EXP_TYPE_SUPPLY = list(titles = supply_positions),
	EXP_TYPE_SECURITY = list(titles = technically_security_positions),
	EXP_TYPE_SILICON = list(titles = list("AI","Cyborg")),
	EXP_TYPE_SERVICE = list(titles = service_positions),
	EXP_TYPE_WHITELIST = list(titles = whitelisted_positions), // karma-locked jobs
	EXP_TYPE_BASE_TUTORIAL = list(), // is basic tutorial complete
))
