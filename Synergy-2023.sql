-- ENO: Request from MSDF to determine how different are the descriptors across districts.
-- Author: Makoa Jacobsen
-- Date: 2022-08-20

-- Description: This extracts all of the codes that would need mapping to the identified Ed-Fi descriptor as outlined in the Synergy documentation.
-- This script is adapted from the CTA developed SynergyCustomDescriptorSync application.

-- Instructions: Select the database in SSMS to run this script against and click execute.
-- Requirements: User must be able to create temporary tables

DROP TABLE IF EXISTS #EdFiDescriptorsToSynergyLookups

-- Create temporary table to store the Ed-Fi to Synergy Lookup Mapping
CREATE TABLE #EdFiDescriptorsToSynergyLookups
(
    EdFiDescriptor varchar(100),
    SynergyLookupNamespace varchar(100),
	SynergyLookupCode varchar(100)
);

-- Insert mapping into temp table
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('AcademicSubjectDescriptor', 'K12.Staff', 'AUT_TEACHING_AREA');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('AcademicSubjectDescriptor', 'K12.CourseInfo', 'SUBJECT_AREA');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('AttendanceEventCategoryDescriptor', 'K12.AttendanceInfo', 'ABSENCE_TYPE');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('CalendarEventDescriptor', 'K12.AttendanceInfo', 'SCHOOL_DAY_TYPES');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('CalendarTypeDescriptor', 'K12.Setup', 'CALENDAR_TYPE');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('CareerPathwayDescriptor', 'K12.CourseInfo', 'CTE_CAREER_CLUSTERS');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('ClassroomPositionDescriptor', 'K12.ScheduleInfo', 'STAFF_RESPONSIBILITY');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('CohortScopeDescriptor', 'K12.StudentGroupsInfo', 'GROUP_CATEGORY');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('CohortTypeDescriptor', 'K12.StudentGroupsInfo', 'GROUP_TYPE');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('CountryDescriptor', 'Revelation', 'COUNTRY');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('CourseAttemptResultDescriptor', 'K12.CourseHistoryInfo', 'MARK');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('CourseLevelCharacteristicDescriptor', 'K12.CourseInfo', 'ACADEMIC_TYPES');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('EntryTypeDescriptor', 'K12', 'ENTER_CODE');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('EntryTypeDescriptor', 'K12.Enrollment', 'ENTER_CODE');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('ExitWithdrawTypeDescriptor', 'K12.Enrollment', 'LEAVE_CODE');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('ExitWithdrawTypeDescriptor', 'K12.Demographics', 'SUMMER_WITHDRAWAL_CODE');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('ExitWithdrawTypeDescriptor', 'K12.Demographics', 'YEAR_END_STATUS');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('GradeLevelDescriptor', 'K12', 'GRADE');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('GraduationPlanTypeDescriptor', 'K12', 'DIPLOMA_TYPE');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('IncidentLocationDescriptor', 'K12.Discipline', 'INCIDENT_LOCATION');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('LanguageDescriptor', 'K12', 'LANGUAGE');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('LanguageInstructionProgramServiceDescriptor', 'K12.ProgramInfo', 'ELL_PROGRAM_CODE');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('LevelOfEducationDescriptor', 'K12', 'STAFF_EDUCATION_LEVEL');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('RaceDescriptor', 'Revelation', 'ETHNICITY');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('RelationDescriptor', 'K12', 'RELATION_TYPE');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('ReporterDescriptionDescriptor', 'K12.DisciplineInfo', 'REFERRER_TYPE');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('ResidencyStatusDescriptor', 'K12.Enrollment', 'SPECIAL_ENROLL_CODE');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('ResponsibilityDescriptor', 'K12.Enrollment', 'TUITION_PAYER_CODE');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('SchoolCategoryDescriptor', 'K12', 'SCHOOL_TYPE');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('SchoolFoodServiceProgramServiceDescriptor', 'K12.ProgramInfo', 'FRM_CODE');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('SexDescriptor', 'Revelation', 'GENDER');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('StaffClassificationDescriptor', 'K12', 'STAFF_TYPE');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('StateAbbreviationDescriptor', 'Revelation', 'STATE');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('StudentParticipationCodeDescriptor', 'K12.Discipline', 'INCIDENT_ROLE');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('TelephoneNumberTypeDescriptor', 'Revelation', 'PHONE_TYPE');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('TermDescriptor', 'K12.ScheduleInfo', 'TERM_CODES');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('TermDescriptor', 'K12.COURSEINFO', 'COURSE_DURATION');
INSERT INTO #EdFiDescriptorsToSynergyLookups VALUES ('WeaponDescriptor', 'K12.DisciplineInfo', 'Weapons');


-- Query synergy lookups with temp table
SELECT (SELECT ORGANIZATION_NAME FROM rev.REV_ORGANIZATION WHERE PARENT_GU is null), EdFiDescriptor, SynergyLookupNamespace, SynergyLookupCode, lookupvalue.VALUE_GU, lookupvalue.VALUE_CODE, lookupvalue.VALUE_DESCRIPTION, lookupvalue.LIST_ORDER, lookupvalue.YEAR_START, lookupvalue.YEAR_END, lookupvalue.ALT_CODE_2, lookupvalue.ALT_CODE_3
FROM #EdFiDescriptorsToSynergyLookups edfimap
JOIN rev.REV_BOD_LOOKUP_DEF lookupdef ON edfimap.SynergyLookupNamespace = lookupdef.LOOKUP_NAMESPACE AND edfimap.SynergyLookupCode = lookupdef.LOOKUP_DEF_CODE
JOIN rev.REV_BOD_LOOKUP_VALUES lookupvalue ON lookupvalue.LOOKUP_DEF_GU = lookupdef.LOOKUP_DEF_GU
-- ProgramTypeDescriptor / Student Needs
UNION 
SELECT (SELECT ORGANIZATION_NAME FROM rev.REV_ORGANIZATION WHERE PARENT_GU is null), 'ProgramTypeDescriptor', null, 'EPC_NEED_DEF', NEED_DEF_GU, STATE_CODE, [DESCRIPTION], null, null, null, null, null
FROM rev.EPC_NEED_DEF
-- 
UNION 
SELECT (SELECT ORGANIZATION_NAME FROM rev.REV_ORGANIZATION WHERE PARENT_GU is null), 'ProgramTypeDescriptor', null, 'EPC_NEED_DEF_PGM', NEED_DEF_PGM_GU, PROGRAM_CODE, PROGRAM_DESCRIPTION, null, null, null, null, null
FROM rev.EPC_NEED_DEF_PGM
--
UNION
SELECT (SELECT ORGANIZATION_NAME FROM rev.REV_ORGANIZATION WHERE PARENT_GU is null), 'DisabilityDescriptor', null, 'EPC_NEED_SPED_DEF', NEED_SPED_DEF_GU, STATE_CODE, [DESCRIPTION], null, null, null, null, null
FROM rev.EPC_NEED_SPED_DEF
--
UNION
SELECT (SELECT ORGANIZATION_NAME FROM rev.REV_ORGANIZATION WHERE PARENT_GU is null), 'SpecialEducationSettingDescriptor', null, 'EPC_NEED_SPED_DEF_SVC', NEED_SPED_DEF_SVC_GU, SERVICE_CODE, SERVICE_DESCRIPTION, null, null, null, null, null
FROM rev.EPC_NEED_SPED_DEF_SVC
--
UNION
SELECT (SELECT ORGANIZATION_NAME FROM rev.REV_ORGANIZATION WHERE PARENT_GU is null), 'GradingPeriodDescriptor', null, 'EPC_SCH_YR_GRD_PRD_MK', SCHOOL_YEAR_GRD_PRD_MK_GU, MARK_NAME_SHORT, MARK_NAME, MARK_ORDER, null, null, MARK_TYPE, CAST(yr.SCHOOL_YEAR as varchar(4)) + '-' + yr.EXTENSION
FROM rev.EPC_SCH_YR_GRD_PRD_MK grdprdmk
JOIN rev.EPC_SCH_YR_GRD_PRD grdprd On grdprdmk.SCHOOL_YEAR_GRD_PRD_GU = grdprd.SCHOOL_YEAR_GRD_PRD_GU
JOIN rev.REV_ORGANIZATION_YEAR orgyr On grdprd.ORGANIZATION_YEAR_GU = orgyr.ORGANIZATION_YEAR_GU
JOIN rev.REV_YEAR yr ON yr.YEAR_GU = orgyr.YEAR_GU
--
UNION
SELECT (SELECT ORGANIZATION_NAME FROM rev.REV_ORGANIZATION WHERE PARENT_GU is null), 'BehaviorDescriptor', null, 'EPC_CODE_DISC', CODE_DISC_GU, DISC_CODE, [DESCRIPTION], null, SCHOOL_YEAR, null, STATE_CODE, null
FROM rev.EPC_CODE_DISC
--
UNION
SELECT (SELECT ORGANIZATION_NAME FROM rev.REV_ORGANIZATION WHERE PARENT_GU is null), 'BehaviorDescriptor', null, 'EPC_CODE_DISC_SUB1', CODE_DISC_SUB1_GU, sub1.DISC_CODE, sub1.[DESCRIPTION], null, SCHOOL_YEAR, null, sub1.STATE_CODE, null
FROM rev.EPC_CODE_DISC_SUB1 sub1
JOIN rev.EPC_CODE_DISC disc ON sub1.CODE_DISC_GU = disc.CODE_DISC_GU
--
UNION
SELECT (SELECT ORGANIZATION_NAME FROM rev.REV_ORGANIZATION WHERE PARENT_GU is null), 'BehaviorDescriptor', null, 'EPC_CODE_DISC_SUB2', CODE_DISC_SUB2_GU, sub2.DISC_CODE, sub2.[DESCRIPTION], null, SCHOOL_YEAR, null, sub2.STATE_CODE, null
FROM rev.EPC_CODE_DISC_SUB2 sub2
JOIN rev.EPC_CODE_DISC_SUB1 sub1 ON sub2.CODE_DISC_SUB1_GU = sub1.CODE_DISC_SUB1_GU
JOIN rev.EPC_CODE_DISC disc ON sub1.CODE_DISC_GU = disc.CODE_DISC_GU
--
UNION
SELECT (SELECT ORGANIZATION_NAME FROM rev.REV_ORGANIZATION WHERE PARENT_GU is null), 'DisciplineDescriptor', null, 'EPC_CODE_DISP', CODE_DISP_GU, DISP_CODE, [DESCRIPTION], null, SCHOOL_YEAR, null, STATE_CODE, null
FROM rev.EPC_CODE_DISP
--
UNION
SELECT (SELECT ORGANIZATION_NAME FROM rev.REV_ORGANIZATION WHERE PARENT_GU is null), 'DisciplineDescriptor', null, 'EPC_CODE_DISC_SUB1', CODE_DISP_SUB1_GU, sub1.DISP_CODE, sub1.[DESCRIPTION], null, SCHOOL_YEAR, null, sub1.STATE_CODE, null
FROM rev.EPC_CODE_DISP_SUB1 sub1
JOIN rev.EPC_CODE_DISP disp ON sub1.CODE_DISP_GU = disp.CODE_DISP_GU
--
UNION
SELECT (SELECT ORGANIZATION_NAME FROM rev.REV_ORGANIZATION WHERE PARENT_GU is null), 'DisciplineDescriptor', null, 'EPC_CODE_DISC_SUB2', CODE_DISP_SUB2_GU, sub2.DISP_CODE, sub2.[DESCRIPTION], null, SCHOOL_YEAR, null, sub2.STATE_CODE, null
FROM rev.EPC_CODE_DISP_SUB2 sub2
JOIN rev.EPC_CODE_DISP_SUB1 sub1 ON sub2.CODE_DISP_SUB1_GU = sub1.CODE_DISP_SUB1_GU
JOIN rev.EPC_CODE_DISP disp ON sub1.CODE_DISP_GU = disp.CODE_DISP_GU
--
UNION
SELECT (SELECT ORGANIZATION_NAME FROM rev.REV_ORGANIZATION WHERE PARENT_GU is null), 'AttendanceEventCategoryDescriptor', null, 'EPC_CODE_ABS_REAS', CODE_ABS_REAS_GU, [ABBREVIATION], [DESCRIPTION], null, SCHOOL_YEAR, null, [TYPE], null
FROM rev.EPC_CODE_ABS_REAS

ORDER BY EdFiDescriptor, SynergyLookupNamespace, SynergyLookupCode, lookupvalue.LIST_ORDER, lookupvalue.VALUE_CODE

DROP TABLE IF EXISTS #EdFiDescriptorsToSynergyLookups
