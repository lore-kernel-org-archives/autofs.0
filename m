From: Michael Blandford <mlblandf@sedona.ch.intel.com>
Subject: Re: Status of >800 mounts
Date: Mon, 14 Jun 2004 15:56:06 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40CE2D06.4070007@sedona.intel.com>
References: <409A7A7C.2000109@sedona.intel.com>
	<20040506185528.GA5149@crashy.west.sun.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040506185528.GA5149@crashy.west.sun.com>
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
To: Stew Smith <stew.smith@sun.com>
Cc: autofs@linux.kernel.org

Stew Smith wrote:

>i am working on a patch currently which multiplexes nfs connections
>per sever so you end up with a 800 server limit, similar to the
>way nfsv4 works now.. i will send it out for review very soon after
>i ferret out a few bugs.
>
>another idea we had was to add SO_REUSEADDR to rpc sockets so
>you have more available on a busy system.
>
>  
>
any updates on this patch? 

Michael

Disclaimer: The content of this message is my personal opinion only and 
although I am an employee of Intel, the statements I make here in no way 
represent Intel's position on the issue, nor am I authorized to speak on 
behalf of Intel on this matter.
