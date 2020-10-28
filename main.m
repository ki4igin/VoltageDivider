%% Init
clearvars;

%% Начальные параметры делителя напряжения
u_in = 50;
u_out = 24;
div_ref = u_out / u_in;

div_ref = 0.228805318;

%% Загрузка ряда номиналов резисторов
ImportSeries;

%% Расчет
result = table(...
    'Size', [width(series), 2], ...
    'VariableTypes', {'double', 'double'}, ...
    'VariableNames', {'R1', 'R2'}, ...
    'RowNames', series.Properties.VariableNames ...
    );

for i = 1:width(series)
    series_cur = table2array(series(:, i));
    N = length(series_cur);
    sum = series_cur * ones(1, N) + (series_cur * ones(1, N))';
    div = (series_cur * ones(1, N)) ./ sum;
    delta = abs(div_ref - div);
    minimum = min(min(delta(:)));
    [row_min, col_min] = find((delta == minimum), 1);

    result(i, :) = {series_cur(col_min), series_cur(row_min)};

end

%% Вывод результата
disp(result);
