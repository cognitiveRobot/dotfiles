# %%
import matplotlib.pyplot as plt
import numpy as np
import plotly.express as px


# %%
def fn(x):
    y = x * 100
    return y


fn(100)
x = np.random.rand(10)
print(x)

# %%
plt.plot(list(range(10)), x)
plt.show()
# %%
fig = px.scatter(x=[0, 1, 2, 3, 4], y=[0, 1, 4, 9, 16])
fig.show()
