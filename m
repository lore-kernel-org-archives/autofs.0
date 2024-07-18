Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9C78564A;
	Thu, 18 Jul 2024 23:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721345821; cv=none; b=Q8JOgnGmhk5VLGT0TiXGXcU96AmokiMafx4m7IDRBQqgalP77bwfI3FyjmxF3NB7lnjM0Gs725m+We115ael1nNJLdc+Q50a9SMoEa/9F4gcV3kzG8hdXB/UifondACjzTS8hoZ61QS3uwMrP7NsJHCpBU56OYkZi3oaef2V8pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721345821; c=relaxed/simple;
	bh=smtS2+CWeRfe2e3JgEKaqC4HezPRhn7ty+Xynx0V4gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOo0jvDVHa6JoWjvhtYuwgaOOMCoK8bukGU+8nLKMOtWKYybhSufF52NntQdfHsqJS8I1hXQLbodFTbHWEQIfETs1lgx6tdtRTa4/reyDCxqzBu+a4uD/v6YK4AQP4SH9a1UMh/oHrI165rNUkOBWkrMRhBUOzH8TxYDAgQ5RWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CNQqwMlE; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CNQqwMlE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721345820; x=1752881820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=smtS2+CWeRfe2e3JgEKaqC4HezPRhn7ty+Xynx0V4gM=;
  b=CNQqwMlEZ22SyXOXVnIZmy88eFOYVZFHkAnIe9vR1lK+k9jZx8gK9iA8
   BwnfdoTrPJWQBmRFljFEwByr+P4cbFAjN1FfMQLLNlvJgdNxckBT93pXK
   JPwp+mX6xsEZk0MYRqKP+atb7sX/doeAGT+myPjtEqHuXqa8HDFIyXuGs
   WqXoOecSfVIltZuAcJSjKHjpdbYHlVsDWOorpStAppesGqruT16Ksd7Wt
   QTbdZ/sI6e0m0uWNrS+JIj1HExq2XAGlG2jRMAlTkGuz5jCh7xjslFFKX
   rrL2RS+Aa5VqvpH6oW+lYXF5y7KOt0avlOKHX6MeQ99LR8bbkOJWAPFnb
   A==;
X-CSE-ConnectionGUID: V0DBpDz/RVensmE5g2snaA==
X-CSE-MsgGUID: ub4xldJGRHao+dhWr9+mRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="30362622"
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; 
   d="scan'208";a="30362622"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 16:36:59 -0700
X-CSE-ConnectionGUID: 4nF54jINR/WpSqgZUoeTsQ==
X-CSE-MsgGUID: jolg39cRQDySgDn3xBO2LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; 
   d="scan'208";a="56083519"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 18 Jul 2024 16:36:56 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUag9-000hfG-1F;
	Thu, 18 Jul 2024 23:36:53 +0000
Date: Fri, 19 Jul 2024 07:36:01 +0800
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
Message-ID: <202407190741.8fA9KJbt-lkp@intel.com>
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
config: arm-randconfig-003-20240719 (https://download.01.org/0day-ci/archive/20240719/202407190741.8fA9KJbt-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240719/202407190741.8fA9KJbt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407190741.8fA9KJbt-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/coda/inode.c: In function 'coda_parse_fd':
>> fs/coda/inode.c:129:13: error: 'param' undeclared (first use in this function); did you mean 'parameq'?
     129 |         if (param->type == fs_value_is_file) {
         |             ^~~~~
         |             parameq
   fs/coda/inode.c:129:13: note: each undeclared identifier is reported only once for each function it appears in
>> fs/coda/inode.c:133:29: error: 'result' undeclared (first use in this function); did you mean 'mf_result'?
     133 |                 file = fget(result->uint_32);
         |                             ^~~~~~
         |                             mf_result


vim +129 fs/coda/inode.c

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
