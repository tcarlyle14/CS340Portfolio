from flask import Flask, redirect, render_template, request, url_for
import os
import database.db_connector as db
import json
from datetime import date

def serialize_date(obj):
    if isinstance(obj, date):
        return obj.isoformat()
    else:
        raise TypeError('Type %s not serializable' % type(obj))

db_connection = db.connect_to_database()

# Configuration

app = Flask(__name__)

# Routes 

@app.route('/')
def root():
    return render_template("main.j2")

@app.route('/agents', methods =["POST","GET"])
def agents():
    if request.method == "GET":
        query = "SELECT * FROM Agents;"
        cursor = db.execute_query(db_connection=db_connection, query=query)
        results = cursor.fetchall()
        return render_template("agents.j2", Agents=results)
    
    if request.method == 'POST':
        # Add a new agent
        name = request.form['name']
        phone = request.form['phone']
        territory = request.form['territory']
        hire_date = request.form['hireDate']
        # Use parameterized query
        query = """
        INSERT INTO Agents (Name, Phone, Territory, HireDate)
        VALUES (%s, %s, %s, %s);
        """
        data = (name, phone, territory, hire_date)
        db.execute_query(db_connection=db_connection, query=query, query_params=data)
        return redirect("/agents")
    
@app.route('/delete_agent', methods=['POST'])
def delete_agent():
    agent_id = request.form['agentID']
    query = "DELETE FROM Agents WHERE `AgentID` = %s;"
    db.execute_query(db_connection=db_connection, query=query, query_params=(agent_id,))
    return redirect("/agents")

@app.route('/update_agent/<int:agent_id>', methods=['GET', 'POST'])
def update_agent(agent_id):
    if request.method == 'GET':
        # Fetch the current data for the agent
        query = "SELECT * FROM Agents WHERE AgentID = %s;"
        cursor = db.execute_query(db_connection=db_connection, query=query, query_params=(agent_id,))
        agent = cursor.fetchone()
        return render_template("edit_agent.j2", agent=agent)
    
    if request.method == 'POST':
        # Update the agent with the new data
        name = request.form['name']
        phone = request.form['phone']
        territory = request.form['territory']
        hire_date = request.form['hireDate']
        query = """
        UPDATE Agents
        SET Name = %s, Phone = %s, Territory = %s, HireDate = %s
        WHERE AgentID = %s;
        """
        data = (name, phone, territory, hire_date, agent_id)
        db.execute_query(db_connection=db_connection, query=query, query_params=data)
        return redirect("/agents")

# Listener

if __name__ == "__main__":
    port = int(os.environ.get('PORT', 54828)) 
    #                                 ^^^^
    #              You can replace this number with any valid port
    
    app.run(port=port, debug=True)