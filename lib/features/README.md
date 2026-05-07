# Features Directory

This directory contains the feature-based architecture of the application.
Each feature is a self-contained module with its own `data`, `domain`, and `presentation` layers.

## Structure

```
features/
  <feature_name>/
    data/
      datasources/
      repositories/
    domain/
      entities/
      repositories/
      usecases/
    presentation/
      bloc/ (or providers/cubits)
      views/
      widgets/
```

## Example: Home Feature

An example `home` feature has been created to demonstrate this structure.
