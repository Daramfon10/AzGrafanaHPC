import tensorflow as tf
import time

# Use MirroredStrategy to spread across all GPUs
strategy = tf.distribute.MirroredStrategy()

print('Number of devices: {}'.format(strategy.num_replicas_in_sync))

with strategy.scope():
    model = tf.keras.applications.ResNet50(weights=None, input_shape=(224, 224, 3), classes=1000)
    model.compile(optimizer='adam', loss='categorical_crossentropy')

batch_size = 512
steps_per_epoch = 100

# Generate random fake data (this will hammer memory and Tensor Cores)
train_dataset = tf.data.Dataset.from_tensor_slices((
    tf.random.normal([batch_size, 224, 224, 3]),
    tf.one_hot(tf.random.uniform([batch_size], 0, 1000, dtype=tf.int32), 1000)
)).repeat().batch(batch_size)

print("Starting training...")

start = time.time()
model.fit(train_dataset, epochs=1, steps_per_epoch=steps_per_epoch)
end = time.time()

print(f"Training completed in {end - start:.2f} seconds")

