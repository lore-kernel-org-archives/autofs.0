From: Peter Staubach <staubach@redhat.com>
Subject: Re: dead lock (autofs and/or mount)
Date: Tue, 07 Nov 2006 09:09:51 -0500
Message-ID: <455093AF.4070700@redhat.com>
References: <454B7750.9000307@infomaniak.ch>	<1162605051.25017.12.camel@localhost>
	<4550455D.1060701@infomaniak.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4550455D.1060701@infomaniak.ch>
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
To: cedric briner <work@infomaniak.ch>
Cc: autofs <autofs@linux.kernel.org>

cedric briner wrote:
>> Don't use -bg.
>>
>>     
> I'm not anymore... and it rocks
>
> For the story, we were using this bg option on Solaris, and it perfeclty 
> works.
>
> thank you for your _precious_ help !

Yes, that is because the Solaris automountd ignores the "bg" and "fg"
options.  They weren't correct to use there either, but it was harmless.

       ps
