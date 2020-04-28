##test test for atria my own

import turicreate as tc
import os

# Load images (Note:'Not a JPEG file' errors are warnings, meaning those files will be skipped)
data = tc.image_analysis.load_images('TEST', with_path=True)

# From the path-name, create a label column
e_text= '/EOSINOPHIL'
l_text= '/LYMPHOCYTE'
m_text = '/MONOCYTE'
n_text = '/NEUTROPHIL'

data['label'] = data['path'].apply(lambda path: os.path.dirname(path).split('/')[-1])

# Save the data for future use
data.save('atria.sframe')

# Explore interactively
data.explore()

data =  tc.SFrame('atria.sframe')

# Make a train-test split
train_data, test_data = data.random_split(0.9)

# Create the model
model = tc.image_classifier.create(train_data, target='label', max_iterations = 20000)
print(model.summary())

# Save predictions to an SArray
predictions = model.predict(test_data)

# Evaluate the model and print the results
metrics = model.evaluate(test_data)
print(metrics['accuracy'])

# Save the model for later use in Turi Create
model.save('atria.model')

# Export for use in Core ML
model.export_coreml('Turi_Atria.mlmodel')

print("yeet")
