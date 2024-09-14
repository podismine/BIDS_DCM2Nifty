

# dicom数据BIDS转档



## 简介
DICOM数据转档到[BIDS格式](https://bids.neuroimaging.io/)

## 镜像创建
```
cd BIDS-dcm2bids
docker build -t msg_dcm2bids:v1.1 .
```

## 运行

```
# 输出目录初始化
docker run -it --rm -v /output_bids_directory:/OUTPUT_DIR msg_dcm2bids:v1.1 dcm2bids_scaffold -o /OUTPUT_DIR
# 单个被试数据转档
docker run -it --rm -v /config_file_localpath/configuration.json:/configuration.json -v /input_dicom_localpath:/INPUT_DIR -v /output_bids_directory:/OUTPUT_DIR msg_dcm2bids:v1.1 dcm2bids -d /INPUT_DIR  -p 001 -c /configuration.json -o /OUTPUT_DIR
# 清除临时文件夹（可选，否则无法通过bids_validator审核）
rm -rf /output_bids_directory/tmp_dcm2bids
```

#### BIDS文件的命名规则：
https://bids-specification.readthedocs.io/en/stable/04-modality-specific-files/01-magnetic-resonance-imaging-data.html


#### 输入参数说明：
-  `-o [path]`: 目标输出BIDS root路径
-  `-d [path]`：dicom输入路径，支持多层文件夹解析。
-  `-p [str]`：被试ID，可以设置任意字符串。比如`-p 001`，则被试ID为`sub-001`
-  `-s [str]`：session ID，可以设置任意字符串。比如`-s 001`，则session ID为`ses-001`
-  `-c [path]`：configuration.json的路径

#### configuration.json说明：
- "searchMethod": "re"：支持REGEX正则表达式
- "caseSensitive": "false"：大小写不敏感
- "descriptions"：定义了具体的序列过滤规则，可以根据具体需要修改

#### 相关说明：
> https://unfmontreal.github.io/Dcm2Bids/
