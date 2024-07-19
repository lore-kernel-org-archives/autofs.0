Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B20D15CB;
	Fri, 19 Jul 2024 01:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721350803; cv=none; b=ZzQkNXheTSnpnx4Yoqe2Atd9C6yTiZawn0j9MdkzvIyrFJYpU6pGTWlUGJpnFgwbPZLyPFFZQMr/6RmlVDAkdxRoOR3fy5dZiYHa94XP410KFZGL4SIAkadUxUOqlDtZupPcwVSVhSnEpqPMy/kVLcsLhP26DbHJ7Oze2jY3RFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721350803; c=relaxed/simple;
	bh=6/B2hRTAeP5Gq6kfz9u4EaA3/DERlz37VXiiJbA6U0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TP8DW1VBPDrSy9Qrt+2Y2hOweCRDPw5sOIt4dvn4hrPoqnEp9BASawo8LE7+eJHKgPCliCWtBr9nsH3d7SPq7zXAU6DXxlSCbmV75WYxt7ZUU1NZxFlCholWVhboxZOB6w4pAQ0T7f355w7Povoo6Mtyhf++gbq6EIROPyHpyfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cKFm/qER; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cKFm/qER"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721350801; x=1752886801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6/B2hRTAeP5Gq6kfz9u4EaA3/DERlz37VXiiJbA6U0w=;
  b=cKFm/qERxmOwiM0LXltmw4IE3Uwnz1T8nMULPkmsFzWvrK5Yc3wl20mS
   spBvSC8/RoONKLYH1kQQhDbziP0EocADG2+IPR/Cqx8PT0FW3ecND7x3V
   +zirLWpUYNrL0djD9T4+F4l0oYHNq1isKzBpxfC0RqMJZnSoflA7d+yNm
   VJDHWkmZ95uaYx6WuEFIAM59Gwfl8RExHJ/D/wFISOzIWU1hgw9EgtXaI
   O4SkZqdeI/FLFp9yraQtZ19q4xAXjuHLN2KsjjXrVBMcOvY81GhpVIe14
   iFq5oNdvUxyMTQs2OlRGrsq/s5+XaKhefPklftkYO5tImrE+40bQJRE+H
   w==;
X-CSE-ConnectionGUID: KDB5tc9YT1mb+4iGodH15Q==
X-CSE-MsgGUID: sv8TBRfZTWOHSRPXjoashg==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="19134054"
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; 
   d="scan'208";a="19134054"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 18:00:00 -0700
X-CSE-ConnectionGUID: /d7kE51YReuF0a/pwnkCrA==
X-CSE-MsgGUID: oMow9NrIQ7yM3UH3Ur4pIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; 
   d="scan'208";a="55806320"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 18 Jul 2024 17:59:57 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUbyV-000hik-15;
	Fri, 19 Jul 2024 00:59:55 +0000
Date: Fri, 19 Jul 2024 08:59:48 +0800
From: kernel test robot <lkp@intel.com>
To: Aleksa Sarai <cyphar@cyphar.com>, Ian Kent <raven@themaw.net>,
	Bill O'Donnell <bodonnel@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
	Eric Sandeen <sandeen@redhat.com>,
	David Howells <dhowells@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, autofs@vger.kernel.org,
	linux-kernel@vger.kernel.org, codalist@coda.cs.cmu.edu,
	Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH 2/2] coda: support FSCONFIG_SET_FD for fd mount flag
Message-ID: <202407190808.l4rcfRij-lkp@intel.com>
References: <20240719-fsconfig-fsparam_fd-fixes-v1-2-7ccd315c2ad4@cyphar.com>
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719-fsconfig-fsparam_fd-fixes-v1-2-7ccd315c2ad4@cyphar.com>

Hi Aleksa,

kernel test robot noticed the following build errors:

[auto build test ERROR on b80cc4df1124702c600fd43b784e423a30919204]

url:    https://github.com/intel-lab-lkp/linux/commits/Aleksa-Sarai/autofs-fix-missing-fput-for-FSCONFIG_SET_FD/20240718-230056
base:   b80cc4df1124702c600fd43b784e423a30919204
patch link:    https://lore.kernel.org/r/20240719-fsconfig-fsparam_fd-fixes-v1-2-7ccd315c2ad4%40cyphar.com
patch subject: [PATCH 2/2] coda: support FSCONFIG_SET_FD for fd mount flag
config: x86_64-randconfig-161-20240719 (https://download.01.org/0day-ci/archive/20240719/202407190808.l4rcfRij-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240719/202407190808.l4rcfRij-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407190808.l4rcfRij-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/coda/inode.c:129:6: error: use of undeclared identifier 'param'
     129 |         if (param->type == fs_value_is_file) {
         |             ^
   fs/coda/inode.c:130:10: error: use of undeclared identifier 'param'
     130 |                 file = param->file;
         |                        ^
   fs/coda/inode.c:131:3: error: use of undeclared identifier 'param'
     131 |                 param->file = NULL;
         |                 ^
>> fs/coda/inode.c:133:15: error: use of undeclared identifier 'result'
     133 |                 file = fget(result->uint_32);
         |                             ^
   4 errors generated.


vim +/param +129 fs/coda/inode.c

   121	
   122	static int coda_parse_fd(struct fs_context *fc, int fd)
   123	{
   124		struct coda_fs_context *ctx = fc->fs_private;
   125		struct file *file;
   126		struct inode *inode;
   127		int idx;
   128	
 > 129		if (param->type == fs_value_is_file) {
   130			file = param->file;
   131			param->file = NULL;
   132		} else {
 > 133			file = fget(result->uint_32);
   134		}
   135		if (!file)
   136			return -EBADF;
   137	
   138		inode = file_inode(file);
   139		if (!S_ISCHR(inode->i_mode) || imajor(inode) != CODA_PSDEV_MAJOR) {
   140			fput(file);
   141			return invalf(fc, "code: Not coda psdev");
   142		}
   143	
   144		idx = iminor(inode);
   145		fput(file);
   146	
   147		if (idx < 0 || idx >= MAX_CODADEVS)
   148			return invalf(fc, "coda: Bad minor number");
   149		ctx->idx = idx;
   150		return 0;
   151	}
   152	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
