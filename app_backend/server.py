from flask import Flask, jsonify, request
import pickle
import numpy as np


app = Flask(__name__)
# reading the model created
model = pickle.load(open('model.pkl', 'rb'))


# post req with body as [40,42,12] and response as predicted disease
@app.route('/v1/predict', methods=['POST'])
def predict_disease():
    data = request.get_json()
    print(data['symptoms'])
    # generating the list to prepare input for model
    symptoms = np.zeros(131)
    for index in data['symptoms']:
        symptoms[index] = 1
    prediction = model.predict([symptoms])
    print(prediction[0])
    # sending the predicted disease with status code
    return jsonify({"result": str(prediction[0])}), 200


if __name__ == "__main__":
    app.run(debug=True, port=8000)
