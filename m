From: Matthew Costello <matthew@ottix.com>
Subject: Re: autofs5: multiple entries with wildcards
Date: Wed, 14 Mar 2007 23:27:21 -0700
Message-ID: <1173940041.22645.3.camel@donner.ottix.com>
References: <1173907255.8503.12.camel@prometheus.workstation.sash-bielefeld.net>
	<m3fy878pty.fsf@redhat.com>
	<1173919596.12589.1.camel@prometheus.workstation.sash-bielefeld.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1173919596.12589.1.camel@prometheus.workstation.sash-bielefeld.net>
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
To: Sascha Frey <sfrey@acs-software.de>
Cc: autofs@linux.kernel.org

On Thu, 2007-03-15 at 01:46 +0100, Sascha Frey wrote:
> ...
> This is what I want, but without NIS.
> I'm testing now with local map files, but I want to store the maps in my
> LDAP directory.

I don't know if this is what you want, but this is the meat of the shell
script I used to create the /etc/auto.home map from LDAP.  Home
directories in my environment don't change all that often so creating a
static map from the LDAP information gives slightly more speed and
higher reliability.

ldapsearch -x -s sub -S cn nisMapName=auto.home cn nisMapEntry | \
sed -e "s/`uname -n`:/:/" | \
awk '$1 == "cn:" { cn=$2 }
$1 == "nisMapEntry:" { printf "%-10s %s,rsize=8192,wsize=8192 %s\n", cn,
$2,$3 }' >> $tmpfile
