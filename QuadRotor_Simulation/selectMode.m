function mode = selectMode(x_error,y_error,z_error)
    error_tol = 0.05;
    if (abs(x_error > error_tol)) | (abs(y_error > error_tol)) | (abs(z_error < error_tol))