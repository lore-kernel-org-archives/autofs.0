From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs + LDAP + STARTTLS
Date: Tue, 1 Feb 2005 10:36:51 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0502011035180.26911@wombat.indigo.net.au>
References: <87hdkxe6jp.fsf@tango.dre.vanderbilt.edu>
Mime-Version: 1.0
In-Reply-To: <87hdkxe6jp.fsf@tango.dre.vanderbilt.edu>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krishnakumar B <kitty@dre.vanderbilt.edu>
Cc: autofs@linux.kernel.org

On Mon, 31 Jan 2005, Krishnakumar B wrote:

> Hi,
> 
> Is there any configuration option that I can use to make autofs execute a
> STARTTLS request before it tries to search the LDAP directory?  I have
> enabled searching the RootDSE in my access control list.  So it should be
> possible for a DUA to get information about

No.

There is no code to do STARTTLS in autofs atm.

Ian
