import sys
import boto3
import json
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.dynamicframe import DynamicFrame
from awsglue.job import Job
from pyspark.sql.functions import *



## @params: [JOB_NAME]
args = getResolvedOptions(sys.argv, ['JOB_NAME'])
def sparkSqlQuery(glueContext, query, mapping, transformation_ctx) -> DynamicFrame:
    for alias, frame in mapping.items():
        frame.toDF().createOrReplaceTempView(alias)
    result = spark.sql(query)
    return DynamicFrame.fromDF(result, glueContext, transformation_ctx)



sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)
glue_context = GlueContext(SparkContext.getOrCreate())
configuration = glue_context.extract_jdbc_conf(
    connection_name="DB2_R2BBILL",
    catalog_id=None
)

# Connecting to the source
df_ratings_sale= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "RATINGS.SALE").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_ratings_sale.createOrReplaceTempView("SALE")

df_ratings_rating= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "RATINGS.RATING").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_ratings_rating.createOrReplaceTempView("RATING")

df_ratings_rating_object= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "RATINGS.RATING_OBJECT").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_ratings_rating_object.createOrReplaceTempView("RATING_OBJECT")

df_ratings_ratable_entity_identifier= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "RATINGS.RATABLE_ENTITY_IDENTIFIER").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_ratings_ratable_entity_identifier.createOrReplaceTempView("RATABLE_ENTITY_IDENTIFIER")

df_ratings_maturity= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "RATINGS.MATURITY").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_ratings_maturity.createOrReplaceTempView("MATURITY")

df_ratings_entity= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "RATINGS.RATABLE_ENTITY").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_ratings_entity.createOrReplaceTempView("ENTITY")

df_ratings_ratable_entity_party_role= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "RATINGS.RATABLE_ENTITY_PARTY_ROLE").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_ratings_ratable_entity_party_role.createOrReplaceTempView("RATABLE_ENTTY_PARTY_ROLE")

df_ratings_party_role= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "RATINGS.PARTY_ROLE").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_ratings_party_role.createOrReplaceTempView("PARTY_ROLE")

df_ratings_party= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "RATINGS.PARTY").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_ratings_party.createOrReplaceTempView("PARTY")

df_ratings_organization= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "RATINGS.ORGANIZATION").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_ratings_organization.createOrReplaceTempView("ORGANIZATION")

df_ratings_competitor_rating= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "RATINGS.COMPETITOR_RATING").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_ratings_competitor_rating.createOrReplaceTempView("COMPETITOR_RATING")

df_refern_competitor_rating_symbol= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "REFERN.COMPETITOR_RATING_SYMBOL").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_refern_competitor_rating_symbol.createOrReplaceTempView("COMPETITOR_RATING_SYMBOL")

df_ratings_rating_analyst_portfolio= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "RATINGS.RATING_ANALYST_PORTFOLIO").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_ratings_rating_analyst_portfolio.createOrReplaceTempView("RATING_ANALYST_PORTFOLIO")

df_ratings_contact_person_role= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "RATINGS.CONTACT_PERSON_ROLE").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_ratings_contact_person_role.createOrReplaceTempView("CONTACT_PERSON_ROLE")

df_ratings_contact_person= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "RATINGS.CONTACT_PERSON").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_ratings_contact_person.createOrReplaceTempView("CONTACT_PERSON")

df_ratings_employee= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "RATINGS.EMPLOYEE").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_ratings_employee.createOrReplaceTempView("EMPLOYEE")


df_refern_contact_person_role_type= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "REFERN.CONTACT_PERSON_ROLE_TYPE").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_refern_contact_person_role_type.createOrReplaceTempView("CONTACT_PERSON_ROLE_TYPE")


df_refern_party_role_type= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "REFERN.PARTY_ROLE_TYPE").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_refern_party_role_type.createOrReplaceTempView("PARTY_ROLE_TYPE")


df_refern_tax_status= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "REFERN.TAX_STATUS").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_refern_tax_status.createOrReplaceTempView("TAX_STATUS")


df_refern_sector_matrix= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "REFERN.SECTOR_MATRIX").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_refern_sector_matrix.createOrReplaceTempView("SECTOR_MATRIX")


df_refern_sector= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "REFERN.SECTOR").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_refern_sector.createOrReplaceTempView("SECTOR")


df_refern_sector_matrix_organization_unit= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "REFERN.SECTOR_MATRIX_ORGANIZATION_UNIT").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_refern_sector_matrix_organization_unit.createOrReplaceTempView("SECTOR_MATRIX_ORGANIZATION_UNIT")


df_refern_debt_type= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "REFERN.DEBT_TYPE").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_refern_debt_type.createOrReplaceTempView("DEBT_TYPE")


df_refern_coupon_type= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "REFERN.COUPON_TYPE").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_refern_coupon_type.createOrReplaceTempView("COUPON_TYPE")


df_refern_coverage_mode= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "REFERN.COVERAGE_MODE").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_refern_coverage_mode.createOrReplaceTempView("COVERAGE_MODE")


df_refern_organization_unit= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "REFERN.ORGANIZATION_UNIT").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_refern_organization_unit.createOrReplaceTempView("ORGANIZATION_UNIT")


df_refern_coverage_role_type= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "REFERN.COVERAGE_ROLE_TYPE").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_refern_coverage_role_type.createOrReplaceTempView("COVERAGE_ROLE_TYPE")


df_refern_organization_unit_membership= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "REFERN.ORGANIZATION_UNIT_MEMBERSHIP").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_refern_organization_unit_membership.createOrReplaceTempView("ORGANIZATION_UNIT_MEMBERSHIP")


df_refern_identifier_type= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "REFERN.IDENTIFIER_TYPE").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_refern_identifier_type.createOrReplaceTempView("IDENTIFIER_TYPE")


df_refern_identifier_type_usage= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "REFERN.IDENTIFIER_TYPE_USAGE").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_refern_identifier_type_usage.createOrReplaceTempView("IDENTIFIER_TYPE_USAGE")


df_refern_rating_attribute= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "REFERN.RATING_ATTRIBUTE").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_refern_rating_attribute.createOrReplaceTempView("RATING_ATTRIBUTE")


df_refern_rating_attribute_type= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "REFERN.RATING_ATTRIBUTE_TYPE").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_refern_rating_attribute_type.createOrReplaceTempView("RATING_ATTRIBUTE_TYPE")


df_refern_rating_symbol= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "REFERN.RATING_SYMBOL").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_refern_rating_symbol.createOrReplaceTempView("RATING_SYMBOL")


df_refern_rating_class= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "REFERN.RATING_CLASS").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_refern_rating_class.createOrReplaceTempView("RATING_CLASS")


df_refern_rating_class_rating_attribute= glueContext.read.format("jdbc").option("driver", "com.ibm.db2.jcc.DB2Driver").option("url",configuration["fullUrl"]).option("dbtable", "REFERN.RATING_CLASS_RATING_ATTRIBUTE").option("user", configuration["user"]).option("password", configuration["password"]).load()
df_refern_rating_class_rating_attribute.createOrReplaceTempView("RATING_CLASS_RATING_ATTRIBUTE")






















job.commit()