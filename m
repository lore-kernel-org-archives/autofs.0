From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Re: [NFS] VFS: Busy inodes after unmount on 2 way SMP
Date: Mon, 15 Sep 2003 15:25:35 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3F663C5F.80207@zytor.com>
References: <Pine.LNX.4.44.0309122013380.9830-100000@moisil.badula.org>
	<3F663246.7010806@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3F663246.7010806@intel.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Arun Sharma <arun.sharma@intel.com>
Cc: Ion Badulescu <lists@cs.columbia.edu>, autofs@linux.kernel.org, nfs@lists.sourceforge.net

Arun Sharma wrote:
>>
>> Oh yeah, easily. Kill the automounter while some things are mounted,
>> unmount everything by hand but do not rmdir the mountpoints. When you
>> unmount the autofs filesystem itself, you will get the self destruct
>> message.
> 
> Thanks. This reproduces the problem I'm chasing very well. I think this
> is clearly an unacceptable kernel bug.
> 
Indeed.  This is on autofs 3?

	-hpa
