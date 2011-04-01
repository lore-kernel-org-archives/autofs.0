From: Frank Thommen <frank.thommen@embl.de>
Subject: Re: different behaviour of autofs
Date: Fri, 01 Apr 2011 09:57:28 +0200
Message-ID: <4D958568.2030904@embl.de>
References: <4D903E64.6050901@mx9.artware.nl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4D903E64.6050901@mx9.artware.nl>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: hugo tempo <hugo@mx9.artware.nl>
Cc: autofs@linux.kernel.org

hugo tempo wrote:
> Hi,
> We (@vu.nl) use the automounter with ldap, a.o. to automount 
> home-directories.
> Now under squeeze if we do a wildcard access (ls /home/* or even ls 
> /home) we get a listing of (seemingly) all the userdirectories from the 
> mountmap (in ldap), which are certainly not all mounted under /home on 
> that specific machine. Same story with /net where we automount packages.
> With lenny we never saw this behaviour, which we honestly do not 
> appreciate.
> Anybody knowing the specifics about this?
> Thanks in advance,
> Hugo Bokman


Maybe the default of the browse mode has changed from "no" to "yes" from 
the previous to the current Linux release ytou are using?

frank
