From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Re: [NFS] VFS: Busy inodes after unmount on 2 way SMP
Date: Tue, 16 Sep 2003 13:54:04 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3F67786C.1020004@zytor.com>
References: <Pine.LNX.4.44.0309122013380.9830-100000@moisil.badula.org>
	<3F663246.7010806@intel.com> <3F663C5F.80207@zytor.com>
	<3F67747C.10403@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3F67747C.10403@intel.com>
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
Cc: Ion Badulescu <lists@cs.columbia.edu>, autofs@linux.kernel.org

Arun Sharma wrote:
> H. Peter Anvin wrote:
> 
>>
>> Indeed.  This is on autofs 3?
>>
> 
> Correction: the problem was primarily seen on autofs4. However the oops
> that I reported yesterday was autofs3. So the problem affects both.
> 
>     -Arun

Thanks.  That's useful information.

	-hpa
