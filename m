From: "Clif J. Smith" <plone@cjs226.com>
Subject: Re: Problem with NIS maps
Date: Wed, 01 Sep 2004 15:36:37 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <413632D5.3090301@cjs226.com>
References: <4133F97E.8060509@cjs226.com>
	<Pine.LNX.4.58.0408312110390.2756@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0408312110390.2756@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent wrote:

>On Mon, 30 Aug 2004, Clif Smith wrote:
>
>  
>
>>I'm in a large heterogeneous environment located across multiple 
>>locations.  I use NIS maps such as:
>>/home -rw austin:/export/home boston:/export/home phoenix:/export/home
>>
>>with the following in /etc/auto.master:
>>/nis      yp      auto_indirect_nis
>>
>>With AIX and Solaris, automounter chooses the server with the fewest
>>hops to determine which server to mount from.  Unfortunately, it appears
>>Suse's 8.1 implementation of automounter (v3.1.7-556) seems to choose 
>>the first listed.
>>    
>>
>
>Sorry, SuSE have chosen not to update to autofs v4.
>
>The most recent version handles this.
>
>You may wish to try building the SRPM from one of the FC distributions.
>
>Ian
>  
>
I ASSuMEd compiling it from source (4.1.3) would be even "cleaner", but 
when I see that /etc/init.d/autofs has:
if [ -f /etc/debian_version ]; then
    system=debian
elif [ -f /etc/redhat-release ]; then
    system=redhat
else
    echo "$0: Unknown system, please port and contact 
autofs@linux.kernel.org" 1>&2
    exit 1
fi

Why is the source so restrictive?

Moving on to the FC SRPM.

cjs
