From: Simon Gao <gao@schrodinger.com>
Subject: Re: autofs-5.0.1-0.rc2.55.el5.3 core dump
Date: Fri, 11 Apr 2008 09:39:31 -0700
Message-ID: <47FF9443.4020305@schrodinger.com>
References: <47FF8D07.7080208@schrodinger.com>
	<x49iqyo9x8i.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49iqyo9x8i.fsf@segfault.boston.devel.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

Jeff Moyer wrote:
> Simon Gao <gao@schrodinger.com> writes:
>
>   
>> Hi,
>>
>> We have many RHEL 5.1 desktops running 2.6.18-53.1.14 X86_64. Many of 
>> them have core dump files related to autofs. The autofs package is
>> autofs-5.0.1-0.rc2.55.el5.3.
>>     
>
>   
>> # strings core.2594 | head
>>     
>
> You can use the 'file' command to determine to what program a core
> belongs:
>
> $ file /tmp/core.2350 
> /tmp/core.2350: ELF 32-bit LSB core file Intel 80386, version 1 (SYSV), SVR4-style, from 'automount'
>
> Anyway, we won't be able to tell why it dumped core without at least a
> stack trace, and preferrably the core file itself.
>
> Cheers,
>
> Jeff
>   
I can provide a core file if you let me know to where I can upload the file?

Simon
