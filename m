From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: VFS: Busy inodes after unmount on 2 way SMP
Date: Wed, 17 Sep 2003 13:41:15 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3F68C6EB.2080706@zytor.com>
References: <Pine.LNX.4.33.0309171251290.25153-100000@wombat.indigo.net.au>
	<3F689E40.6090802@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3F689E40.6090802@intel.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Arun Sharma <arun.sharma@intel.com>
Cc: autofs@linux.kernel.org, nfs@lists.sourceforge.net, Ian Kent <raven@themaw.net>

Okay... let me ask this so I get it straight...

Has anyone seen this (busy inodes after stopping the automounter) using 
autofs v3 kernel module and daemon?

	-hpa
