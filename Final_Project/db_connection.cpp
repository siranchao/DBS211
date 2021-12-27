//DBS211 - Group Project - Milestone 1
//Section: NCC
//Group: 8
//Student Name: Siran Cao(159235209);  Sitong Wang(138148200);  Yang Yang(151915204);

//Description: Milestone-1 .cpp file
//Version: 1.0
//Date: 2021/11/07
///////////////////////////////////////////////////////////////////

#include <iostream>
#include <string>
#include <occi.h>

using oracle::occi::Environment;
using oracle::occi::Connection;
using namespace oracle::occi;
using namespace std;

// Utility functions
const int MIN_ID = 1000;
const int MAX_ID = 9999;
void headerLine();
void header(const char* report);
void display(Number id, string firstname, string lastname, string phone, string ext);
int validInput(std::istream& istr, int min, int max);

int main(void) {
	// OCCI object pointers
	Environment* env = nullptr;
	Connection* conn = nullptr;
	Statement* stmt = nullptr;
	ResultSet* rs = nullptr;

	// User login info
	string user = "dbs211_213c08";	// login
	string pass = "30496203";	// password 
	string srv = "myoracle12c.senecacollege.ca:1521/oracle12c"; // server

	//// Create environment and connect to the database
	try {
		env = Environment::createEnvironment(Environment::DEFAULT);
		conn = env->createConnection(user, pass, srv);
		cout << "Connection is Successful!" << endl;
		cout << "----->>> Group 8 <<<-----" << endl;
		cout << "Group members:" << endl;
		cout << "Siran Cao(159235209)  Sitong Wang(138148200)  Yang Yang(151915204)" << endl;
		headerLine();
	}
	catch (SQLException& sqlExcp) {
		// handling error message
		cerr << "Connection Failed: " << endl;
		cerr << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
	}

	//// Entering SQL executions
	if (conn) {
		int selection;
		int emp_id;
		string sql;
		// Create a sql statement
		stmt = conn->createStatement();

		do {
			cout << "Please enter your selection: " << endl;
			cout << "1 - Display all employee records" << endl;
			cout << "2 - Search by an employee number" << endl;
			cout << "0 - Exit" << endl;
			cout << "> ";
			selection = validInput(cin, 0, 2);

			// 1st Query //
			if (selection == 1) {
				try {
					// execute sql statement-1
					sql = "SELECT e.employeenumber, e.firstname, e.lastname, o.phone, e.extension From dbs211_employees e LEFT JOIN dbs211_offices o ON e.officecode = o.officecode ORDER BY e.employeenumber";
					stmt->setSQL(sql);
					rs = stmt->executeQuery();

					header("Employee Report");
					// fetch results row by row
					if (!rs->next()) {
						cout << "Empty Results!" << endl;
					}
					else {
						do {
							Number id = rs->getNumber(1);
							string firstName = rs->getString(2);
							string lastName = rs->getString(3);
							string phone = rs->getString(4);
							string ext = rs->getString(5);
							display(id, firstName, lastName, phone, ext);
						} while (rs->next());
					}
				}
				catch (SQLException& sqlExcp) {
					cerr << "SQL Execution Failed: " << endl;
					cerr << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
				}
				headerLine();
			}
			// 2nd Query //
			else if (selection == 2) {
				try {
					// Prompt for input
					cout << "Please enter an employee ID: ";
					emp_id = validInput(cin, MIN_ID, MAX_ID);

					sql = "SELECT e.employeenumber, e.firstname, e.lastname, o.phone, e.extension From dbs211_employees e LEFT JOIN dbs211_offices o ON e.officecode = o.officecode WHERE e.employeenumber = :1 ORDER BY e.employeenumber";
					stmt->setSQL(sql);
					// Alter parameter for the statement
					stmt->setInt(1, emp_id);
					rs = stmt->executeQuery();

					header("Employee Report");
					if (!rs->next()) {
						////////////////////// check output
						cout << "Cannot find this employee! Please try again" << endl;
					}
					else {
						do {
							Number id = rs->getNumber(1);
							string firstName = rs->getString(2);
							string lastName = rs->getString(3);
							string phone = rs->getString(4);
							string ext = rs->getString(5);
							display(id, firstName, lastName, phone, ext);
						} while (rs->next());
					}
				}
				catch (SQLException& sqlExcp) {
					cerr << "SQL Execution Failed: " << endl;
					cerr << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
				}
				headerLine();
			}

		} while (selection != 0);

		// Terminate sql Statement
		conn->terminateStatement(stmt);
	}

	// Terminate connection and environment
	env->terminateConnection(conn);
	Environment::terminateEnvironment(env);

	return 0;
}



void headerLine() {
	cout << endl;
	cout.fill('-');
	cout.width(70);
	cout << "" << endl;
	cout.fill(' ');
}
void header(const char* report) {
	cout << endl;
	// line 1
	cout.fill('-');
	cout.width(35);
	cout << "";
	cout << report;;
	cout.width(30);
	cout << "" << endl;
	cout.fill(' ');
	// line 2
	cout.setf(ios::left);
	cout.width(12);
	cout << "Employee ID" << "  ";
	cout.width(17);
	cout << "First Name" << "  ";
	cout.width(17);
	cout << "Last Name" << "  ";
	cout.width(16);
	cout << "Phone" << "  ";
	cout.width(10);
	cout << "Extension" << endl;
	// line 3
	cout.fill('-');
	cout.width(12);
	cout << "" << "  ";
	cout.width(17);
	cout << "" << "  ";
	cout.width(17);
	cout << "" << "  ";
	cout.width(16);
	cout << "" << "  ";
	cout.width(10);
	cout << "" << endl;
	cout.fill(' ');
}
void display(Number id, string firstname, string lastname, string phone, string ext) {
	cout.setf(ios::left);
	cout.width(12);
	cout << (int)id << "  ";
	cout.width(17);
	cout << firstname << "  ";
	cout.width(17);
	cout << lastname << "  ";
	cout.width(16);
	cout << phone << "  ";
	cout.width(10);
	cout << ext << endl;
}
int validInput(std::istream& istr, int min, int max) {
	int res = 0;
	istr >> res;
	while (!istr || res < min || res > max) {
		istr.clear();
		istr.ignore(1024, '\n');
		cout << "Please enter a valid number(" << min << " - " << max << "): ";
		istr >> res;
	}
	return res;
}