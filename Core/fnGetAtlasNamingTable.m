function [acFullNames, acShortNames]=fnGetAtlasNamingTable()
acFullNames = {
    'Somatosensory areas 1 and 2'
    'Somatosensory areas 3a and 3b'
    'third ventricle'
    'Primary motor cortex'
    'Premotor area 4C'
    'Somatosensory area 5 (complex)'
    'Dorsal premotor area 6, caudal subdivision'
    'Dorsal premotor area 6, rostral subdivision'
    'Ventral premotor area'
    'Ventral premotor area'
    'Visual area 7a'
    'Visual area 7b'
    'Area 7m in the medial parietal cortex'
    'Area 7op (parietal operculum)'
    'Transitional area 7 near lip of ips'
    'Area 8A'
    'Area 8B, dorsal subdivision'
    'Area 8B, medial subdivision'
    'Area 8B in the arcuate sulcus'
    'Area 9, dorsal subdivision'
    'Area 9, medial subdivision'
    'Area 10m'
    'Area 10o'
    'Area 11l'
    'Area 11m'
    'Area 12l'
    'Area 12m'
    'Area 12o '
    'Area 12r'
    'Area 13a'
    'Area 13b '
    'Area 13l'
    'Area 13m '
    'Area 14c '
    'Area 14r'
    'Area 23a in posterior cingulate cortex'
    'Area 23b in posterior cingulate cortex'
    'Area 23c in posterior cingulate cortex'
    'Area v23a in posterior cingulate cortex'
    'Area v23b in posterior cingulate cortex'
    'Area 24a in anterior cingulate cortex'
    'Area 24a'''' in anterior cingulate cortex'
    'Area 24b in anterior cingulate cortex'
    'Area 24b'''' in anterior cingulate cortex'
    'Area 24c in anterior cingulate cortex'
    'Area 24c'''' in anterior cingulate cortex'
    'Area 25'
    'Area 29 (retrosplenial cortex) '
    'Area 30 (retrosplenial cortex)'
    'Area 31 in the posterior cingulate gyrus'
    'Area 32'
    'Area 35 of the perirhinal cortex'
    'Area 36 of the perirhinal cortex, caudal subregion'
    'Area 36 of the perirhinal cortex, temporal-polar subregion'
    'Area 36 of the perirhinal cortex, rostral subregion'
    'Area 44'
    'Area 45'
    'Area 46, dorsal subdivision'
    'Area 46, ventral subdivision'
    'Anterior amygdaloid area'
    'Accessory basal nucleus of amygdala'
    'Accessory basal nucleus of amygdala, magnocelluar'
    'Accessory basal nucleus of amygdala, parvicellular'
    'Anterior commissure'
    'Anterior dorsal nucleus'
    'Amygdalohippocampal area'
    'Anterior hypothalamic areas'
    'Auditory area I, core region of the auditory cortex'
    'Anterior intraparietal area '
    'Anterior lateral, belt region of the auditory cortex'
    'Anterior medial nucleus'
    'Anterior middle temporal sulcus'
    'Amygdala'
    'Anterior ofactory nucleus'
    'Anterior ofactory nucleus, dorsal division'
    'Anterior ofactory nucleus, lateral division'
    'Anterior ofactory nucleus, medial division'
    'Anterior parieto-occipital sulcus'
    'Aqueduct'
    'Arcuate hypothalamic nucleus'
    'Arcuate sulcus lower limb'
    'Arcuate sulcus upper limb'
    'Anterior ventral nucleus'
    'Basal Nucleus of amygdala'
    'Basal Nucleus of amygdala, intermediate subdivision'
    'Basal Nucleus of amygdala, magnocellular subdivision '
    'Basal Nucleus of amygdala, parvicellular subdivision'
    'Brachium of superior colliculus'
    'CA1 subfield of hippocampus'
    'CA2 subfield of hippocampus'
    'CA3 subfield of hippocampus'
    'CA4 subfield of hippocampus'
    'Capsule of the anterior nuclei'
    'Calcarine sulcus'
    'cerebellum'
    'Corpus callosum'
    'Caudate nucleus'
    'Central dorsocellular nucleus'
    'Central nucleus of amygdala'
    'Central inferior nucleus'
    'Central intermediate nucleus'
    'Cingulate sulcus'
    'Caudal lateral, belt region of the auditory cortex'
    'Central lateral nucleus'
    'Claustrum'
    'Central latocellular nucleus'
    'Caudomedial, belt region of the auditory cortex'
    'Centromedian nucleus'
    'Anterior cortical nucleus'
    'Posterior cortical nucleus'
    'Cerebral peduncle'
    'Central sulcus'
    'Central superior lateral nucleus'
    'Dentate gyrus'
    'Dorsolateral periaqueductal gray'
    'Dorsomedial hypothalamic nucleus'
    'Dorsomedial periaqueductal gray'
    'Dorsal prelunate area'
    'Dorsal raphe'
    'Entorhinal cortex, caudal division'
    'Entorhinal cortex, caudal limiting division'
    'Entorhinal cortex, intermediate division'
    'Entorhinal cortex, lateral division (caudal part)'
    'Entorhinal cortex, lateral division (rostral part)'
    'Entorhinal cortex, olfactroy division'
    'Entorhinal cortex, rostral division'
    'Fornix'
    'Agranular frontal area F1'
    'Agranular frontal area F2'
    'Agranular frontal area F3'
    'Agranular frontal area F4'
    'Agranular frontal area F5'
    'Agranular frontal area F6'
    'Agranular frontal area F7'
    'Fasciculus retroflexus'
    'Floor of superior temporal area'
    'Gustatory cortex'
    'Globus pallidus, external segment'
    'Globus pallidus, internal segment'
    'Hippocampus'
    'Hippocampal fissure'
    'Habenular nucleus'
    'Lateral habenular nucleus'
    'Medial habenular nucleus'
    'Intercalated nucleus'
    'Agranular insula'
    'Intermediate agranular insula area'
    'Lateral agranular insula area'
    'Medial agranular insula area'
    'Posterolateral agranular insula area'
    'Posteromedial agranular insula area'
    'Inferior colliculus'
    'Internal capsule'
    'Dysgranular insula'
    'Granular insula'
    'Third cranial nerve nuclei (oculomotor)'
    'Oculomotor nerve (cranial nerve)'
    'Inferior occipital sulcus'
    'Area IPa (sts fundus)'
    'Intraparietal sulcus'
    'Fourth cranial nerve nucleus (trochlear)'
    'Lateral nucleus of amygdala'
    'Lateral dorsal nucleus'
    'Lateral nucleus of amygdala, dorsal subdivision'
    'Lateral geniculate nucleus'
    'Lateral hypothalamic area '
    'Lateral intraparietal area'
    'Lateral intraparietal area, dorsal subdivision'
    'Lateral intraparietal area, ventral subdivision'
    'External medullary lamina'
    'Lateral occipital parietal area'
    'Lateral orbital sulcus'
    'Lateral posterior nucleus'
    'Lateral periaqueductal gray'
    'Lateral sulcus'
    'Lateral septum, dorsal part'
    'Lateral septum, intermediate part'
    'Lateral septum, ventral part'
    'Lunate sulcus'
    'Lateral nucleus of amygdala, ventral subdivision'
    'Lateral ventricle'
    'Middle cerebellar peduncle'
    'Medial dorsal nucleus, densocellular division'
    'Mediodorsal nucleus, magnocellular division'
    'Mediodorsal nucleus, multiform division'
    'Mediodorsal nucleus, parvicellular division'
    'Medial nucleus of amygdala'
    'Medial geniculate nucleus'
    'Medial intraparietal area'
    'Medial lemniscus'
    'Middle lateral, belt region of the auditory cortex'
    'Molecular layer'
    'Medial longitudinal fasciculus'
    'Mammillary nucleus'
    'Medial orbital sulcus'
    'Medial preoptic area'
    'Median raphe'
    'Medial septum'
    'Medial superior temporal area'
    'Middle temporal area'
    'Mammillo thalamic tract'
    'Nucleus accumbens'
    'Nucleus accumbens, core'
    'Nucleus accumbens, shell'
    'Nucleus basalis of Meynert'
    'Nucleus of the lateral olfactory tract'
    'Optic chiasm'
    'Olfactory tubercle'
    'Optic tract'
    'Occipitotemporal sulcus'
    'Pulvinar'
    'Paraventricular nucleus'
    'Periamygdaloid cortex'
    'Periamygdaloid cortex 2'
    'Periamygdaloid cortex 3'
    'Periamygdaloid cortex o'
    'Periamygdaloid cortex, sulcal portion'
    'Periaqueductal gray'
    'Parasubiculum'
    'Paracentral nucleus'
    'Parafascicular nucleus'
    'Area PGa'
    'Inferior pulvinar'
    'Parainsular area'
    'Posterior intraparietal area'
    'Piriform cortex'
    'Lateral pulvinar'
    'Paralaminar nuclues in amygdala'
    'Medial pulvinar'
    'Polymorphic layer'
    'Posterior middle temporal sulcus'
    'Pontine nuclei'
    'Parieto-occipital area'
    'Parieto-occipital sulcus'
    'Precentral opercular area'
    'Presubiculum'
    'Presupplementary motor area'
    'Prosubiculum'
    'Principal sulcus'
    'Parataenial oralis nucleus'
    'Paraventricular hypothalamic nucleus'
    'Reticular nucleus'
    'Rostral, core region on the auditory cortex'
    'Reunions nucleus'
    'Retroinsula'
    'Rostromedial, belt region of the auditory cortex'
    'Red nucleus'
    'Rhinal sulcus'
    'Rostrotemporal, core region of the auditory cortex'
    'Lateral rostrotemporal, belt region of the auditory cortex'
    'Medial rostrotemporal, belt region of the audditory cortex'
    'Rostrotemporal ("p" refers to polar)'
    'Spur of the arcuate sulcus'
    'Superior colliculus'
    'Suprachiasmatic nucleus '
    'Superior cerebellar peduncle'
    'Substantia innominata'
    'Secondary somatesensory area (S2)'
    'Stria medullaris'
    'Supplementary motor area'
    'Substantia nigra'
    'Substantia nigra pars compacta'
    'Substantia nigra pars reticulate'
    'Supraoptic nucleus'
    'Superior precentral dimple'
    'septum'
    'Caudal superior temporal gyrus'
    'Rostral superior temporal gyrus'
    'Subthalamic nucleus'
    'Superior temporal sulcus'
    'Subiculum'
    'Area TAa (sts dorsal bank)'
    'Area TEa (sts ventral bank)'
    'Dorsal subregion of anterior TE'
    'Ventral subregion of anterior TE'
    'Area TEm (sts ventral bank)'
    'Area TEO'
    'Dorsal subregion of posterior TE'
    'Ventral subregion of posterior TE'
    'Area TF of the parahippocampal cortex'
    'Area TFO of the parahippocampal cortex'
    'Agranular part of the temporal pole'
    'Dorsal temporal pole'
    'Dysgranular part of the dorsal temporal pole'
    'Granular part of the dorsal temporal pole'
    'Sts part of the temporal pole'
    'Ventral temporal pole'
    'Ventral dysgranular part of the temporal pole '
    'Ventral granular part of the temporal pole'
    'Area TH of the parahippocampal cortex'
    'Habenular interpeduncular tract'
    'Area TPO (sts dorsal bank)'
    'Temporo-parietal area'
    'Ventral tenia tectum'
    'Ventricle'
    'Visual area 1 (primary visual cortex)'
    'Visual area 2'
    'Area v23a in posterior cingulate cortex'
    'Area v23b in posterior cingulate cortex'
    'Visual area V3A'
    'Visual area V3, dorsal area'
    'Visual area V3, ventral area'
    'Visual area 4 (dorsal part)'
    'V4 transitional area'
    'Visual area 4, ventral part'
    'Ventral anterior nucleus'
    'Ventral anterior nuclues, magnocellular division'
    'Nucleus of vertical limb of diagonal band'
    'Ventral intraparietal area'
    'Ventral lateral caudal nucleus'
    'Ventral lateral medial nucleus'
    'Ventral lateral oral nucleus'
    'Ventrolateral periaqueductal gray'
    'Ventromedial hypothalamic nuclues'
    'Ventral pallidum'
    'Ventral posterior inferior nucleus'
    'Ventral posterior lateral caudal nucleus'
    'Ventral posterior lateral oral nucleus'
    'Ventral posterior medial nucleus'
    'Ventral posterior medial nucleus, parvicellular division'
    'Zona incerta'};
acShortNames = {
  '1-2'
    '3a/b'
    '3v '
    '4'
    '4C '
    '5 '
    '6DC'
    '6DR'
    '6Va'
    '6Vb'
    '7a '
    '7b'
    '7m'
    '7op'
    '7t '
    '8A'
    '8Bd'
    '8Bm'
    '8Bs'
    '9d '
    '9m'
    '10m '
    '10o'
    '11l'
    '11m '
    '12l'
    '12m '
    '12o'
    '12r'
    '13a'
    '13b '
    '13l'
    '13m '
    '14c'
    '14r '
    '23a '
    '23b '
    '23c '
    'v23a'
    'v23b '
    '24a'
    '24a'''''
    '24b '
    '24b'''''
    '24c '
    '24c'''''
    '25 '
    '29 '
    '30'
    '31 '
    '32 '
    '35 '
    '36c '
    '36p'
    '36r '
    '44'
    '45 '
    '46d'
    '46v'
    'AAA'
    'AB'
    'ABmc'
    'ABpc'
    'AC '
    'AD '
    'AHA '
    'AHA '
    'AI '
    'AIP'
    'AL '
    'AM '
    'amts'
    'amy '
    'AON '
    'AONd '
    'AONl'
    'AONm '
    'apos '
    'aq'
    'Arh'
    'asl '
    'asu '
    'AV'
    'B'
    'Bi'
    'Bmc '
    'Bpc'
    'bsc '
    'CA1 '
    'CA2'
    'CA3'
    'CA4 '
    'can '
    'cas'
    'cb '
    'CC'
    'cd'
    'cdc'
    'CE '
    'cif '
    'cim '
    'cis '
    'CL'
    'cl '
    'cla'
    'clc'
    'CM'
    'cnMD'
    'COa'
    'COp'
    'CP'
    'cs'
    'csl'
    'DG '
    'dlPAG'
    'DMH'
    'dmPAG'
    'DP'
    'DR'
    'EC '
    'ECL'
    'EI'
    'ELc'
    'ELr'
    'EO'
    'ER '
    'f'
    'F1'
    'F2'
    'F3 '
    'F4 '
    'F5 '
    'F6'
    'F7'
    'fr'
    'FST'
    'G'
    'GPe'
    'GPi'
    'HC'
    'hf'
    'Hi'
    'Hl'
    'Hm'
    'I'
    'Ia '
    'Iai'
    'Ial'
    'Iam'
    'Iapl'
    'Iapm'
    'IC'
    'ic'
    'Id'
    'Ig'
    'III'
    'IIIN'
    'ios'
    'IPa '
    'ips'
    'IC'
    'L'
    'LD'
    'Ld'
    'LGN'
    'LHA'
    'LIP'
    'LIPd'
    'LIPv'
    'Lme'
    'LOP'
    'los'
    'LP'
    'lPAG'
    'ls'
    'lsd'
    'lsi'
    'lsv'
    'lus'
    'Lv'
    'lv'
    'mcp'
    'MDdc'
    'MDmc '
    'MDmf'
    'MDpc'
    'ME'
    'MGN'
    'MIP'
    'ml'
    'ML'
    'ml'
    'Mlf'
    'MN'
    'mos'
    'MPOA'
    'MR'
    'ms'
    'MST'
    'MT'
    'MTT'
    'NA'
    'NAc'
    'NAsh'
    'NBM'
    'NLOT'
    'oc'
    'OT'
    'ot'
    'ots'
    'P'
    'Pa '
    'PAC'
    'PAC2'
    'PAC3 '
    'PACo'
    'PACs'
    'PAG '
    'paraS'
    'Pcn'
    'Pf'
    'PGa'
    'PI'
    'Pi'
    'PIP'
    'Pir'
    'PL'
    'PL'
    'PM'
    'pm'
    'pmts'
    'PN'
    'PO'
    'pos'
    'PrCO'
    'preS'
    'PreSMA'
    'proS'
    'ps'
    'pt'
    'PVN'
    'r'
    'R'
    'Re'
    'Ri'
    'RM'
    'RN'
    'rs'
    'RT'
    'RTL'
    'RTM'
    'RTp'
    'sas'
    'SC'
    'SCN'
    'scp'
    'SI'
    'SII'
    'Sm'
    'SMA'
    'SN'
    'SNc'
    'SNr'
    'SON'
    'spcd'
    'spt'
    'STGc'
    'STGr'
    'STN'
    'sts'
    'Sub'
    'TAa'
    'TEa'
    'TEad'
    'TEav'
    'TEm'
    'TEO'
    'TEpd'
    'TEpv'
    'TF'
    'TFO'
    'TGa'
    'TGd'
    'TGdd'
    'TGdg'
    'TGsts'
    'TGv'
    'TGvd'
    'TGvg'
    'TH'
    'THI'
    'TPO'
    'Tpt'
    'TTv'
    'V'
    'V1 '
    'V2'
    'v23a'
    'v23b'
    'V3A'
    'V3d'
    'V3v'
    'V4'
    'V4t'
    'V4v'
    'VA'
    'VAmc'
    'vdb'
    'VIP '
    'VLc'
    'VLm'
    'VLo'
    'vlPAG'
    'VLps'
    'VP'
    'VPI'
    'VPLc'
    'VPLo'
    'VPM'
    'VPMpc'
    'zic'};


    