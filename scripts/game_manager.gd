extends Node

@onready var points_label: Label = %PointsLabel
@export var hearts : Array[Node]
@onready var sqlite: SQLite

var points = 0
var lives = 3
var db : SQLite = null  # Declare the SQLite object

# Initialize the database
func _ready():
	db = SQLite.new()	
	db.path = "user://game_data.db"  # Assign path first
	db.open_db()  # Then open the database
	db.query("CREATE TABLE IF NOT EXISTS game_stats (id INTEGER PRIMARY KEY, total_points INTEGER);")
	_load_game_data()

# Load the saved game data from the database
func _load_game_data():
	var success = db.query("SELECT total_points FROM game_stats WHERE id = 1;")
	if success:
		var result = db.query_result
		if result.size() > 0:
			points = result[0]["total_points"]
	else:
		print("Query failed.")
	points_label.text = "Points: " + str(points)

# Decrease health function
func decrease_health():
	lives -= 1
	for h in range(hearts.size()):
		if (h < lives):
			hearts[h].show() 
		else:
			hearts[h].hide()
	if (lives == 0):
		get_tree().reload_current_scene()

# Add points and update the database
func add_point():
	points += 1
	points_label.text = "Points: " + str(points)

# Update the total points in the database
func _update_points_in_db():
	# Insert or update points in the database
	var sql = "INSERT OR REPLACE INTO game_stats (id, total_points) VALUES (1, %d);" % points
	var success = db.query(sql)
	if not success:
		print("Failed to update points in the database.")
