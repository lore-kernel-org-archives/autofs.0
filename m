From: raven@themaw.net
Subject: Re: [PATCH] check nsswitch.conf for submounts
Date: Tue, 1 Mar 2005 21:19:33 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0503012118390.14747@donald.themaw.net>
References: <421D05BF.5000206@redhat.com>
	<Pine.LNX.4.61.0502271124090.8184@donald.themaw.net>
	<42234E46.7090003@redhat.com>
Mime-Version: 1.0
In-Reply-To: <42234E46.7090003@redhat.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Chris Feist <cfeist@redhat.com>
Cc: autofs@linux.kernel.org

On Mon, 28 Feb 2005, Chris Feist wrote:

> raven@themaw.net wrote:
>> This is a really useful bit of code.
>> Appart from addressing the default map problem, it is one of the pieces 
>> of code needed to move logic out of the init script.
>> 
>> Howerver, we can't assume that maps are stored in "/etc".
>> This really should be a configure logical.
>
> We do use _PATH_NSSWITCH_CONF for the location of the nsswitch.conf file 
> which is defined in netdb.h.  So if that file was someplace else I would 
> expect that the changes would need to be made in netdb.h (for glibc, etc.)

It's the autofs maps location I'd like to have configurable.

Ian
