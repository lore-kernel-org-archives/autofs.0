From: Michael Blandford <mlblandf@sedona.ch.intel.com>
Subject: Re: Problem with NIS maps
Date: Tue, 31 Aug 2004 08:43:33 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <41349CA5.6030105@sedona.intel.com>
References: <4133F97E.8060509@cjs226.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4133F97E.8060509@cjs226.com>
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
To: Clif Smith <kernel@cjs226.com>
Cc: autofs@linux.kernel.org

Clif Smith wrote:

> I'm in a large heterogeneous environment located across multiple 
> locations.  I use NIS maps such as:
> /home -rw austin:/export/home boston:/export/home phoenix:/export/home
>
> with the following in /etc/auto.master:
> /nis      yp      auto_indirect_nis
>
> With AIX and Solaris, automounter chooses the server with the fewest
> hops to determine which server to mount from.  Unfortunately, it appears
> Suse's 8.1 implementation of automounter (v3.1.7-556) seems to choose 
> the first listed.
>
> Has anyone run into this before?


Yes, it is called replicated server.

It is supported in the autofs-4.1.x family.  You should upgrade.

Disclaimer: The content of this message is my personal opinion only and 
although I am an employee of Intel, the statements I make here in no way 
represent Intel's position on the issue, nor am I authorized to speak on 
behalf of Intel on this matter.

Michael
