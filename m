From: abo <abo@brujulatelecom.com>
Subject: smbfs credentias
Date: Wed, 5 Jan 2005 13:16:18 +0100
Message-ID: <20050105131618.1ccfca62@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

hi!

im trying to mount smbfs resources from an ldap

if i put in nisMapEntry this

-fstype=smbfs,credentials=/home/abo/smb.creds

everything is working right. then i want to do it per user but variable
substitution doesn't work, i tried:

-fstype=smbfs,credentials=/home/$USER/smb.creds

-fstype=smbfs,credentials=/home/${USER}/smb.creds

-fstype=smbfs,credentials=~/smb.creds

but no succes.

how can i get per user credentiasl? im on the wrong direction?

thx

abo
